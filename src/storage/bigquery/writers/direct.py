from typing import Any
import asyncio
import time

from google.cloud.bigquery_storage_v1.services.big_query_write.async_client import (
    BigQueryWriteAsyncClient,
)
from google.cloud.bigquery_storage_v1.types import (
    AppendRowsRequest,
    ProtoRows,
    ProtoSchema,
)
from google.protobuf import descriptor_pb2
from google.protobuf.json_format import ParseDict
from google.api_core.retry_async import AsyncRetry
from google.cloud.bigquery.table import TableReference

from src.core.config import settings
from src.storage.bigquery.proto import StreamingMessage
from src.storage.bigquery.writers.base import StreamerProtocol
from src.log_config import logger

# Module-level constants (initialized once at import)
_PROTO_DESCRIPTOR = descriptor_pb2.DescriptorProto()
StreamingMessage.DESCRIPTOR.CopyToProto(_PROTO_DESCRIPTOR)      
_PROTO_SCHEMA = ProtoSchema(proto_descriptor=_PROTO_DESCRIPTOR)


# ==============================================================================
# High Performance / Streaming Implementation
# ==============================================================================

class DirectStreamer(StreamerProtocol):
    """
    High-performance streamer for BigQuery Storage Write API.
    Maintains a persistent gRPC connection and batches rows.
    """
    def __init__(
        self,
        client: BigQueryWriteAsyncClient,
        # Settings can be overridden, otherwise load from config
    ):
        self.client = client
        
        # Resolve table path from settings once
        self.table_path = settings.writers.bq.table_path(settings.writers.project_id)
        
        # Settings (Use provided args or fallback to global settings)
        self.flush_interval: float = settings.writers.bq.flush_interval
        self.max_batch_size: int = settings.writers.bq.max_batch_size
        self.max_queue_size: int = settings.writers.bq.max_queue_size
        
        # Internal State
        self._queue: asyncio.Queue = asyncio.Queue(maxsize=self.max_queue_size)
        self._request_queue: asyncio.Queue = asyncio.Queue()  # For sending to BQ stream
        self._worker_task: asyncio.Task | None = None
        self._response_task: asyncio.Task | None = None
        self._stream_manager_task: asyncio.Task | None = None
        self._is_running = False

    async def start(self):
        """Starts the background worker and stream manager."""
        if self._is_running:
            return

        self._is_running = True
        logger.info(f"Starting BigQueryStreamer for {self.table_path}")
        logger.info(f"Streamer Config: Batch={self.max_batch_size}, Flush={self.flush_interval}s, Queue={self.max_queue_size}")
        
        # Start the batch assembler
        self._worker_task = asyncio.create_task(self._batch_worker(), name="bq_batch_worker")
        
        # Start the stream manager (handles the gRPC connection)
        self._stream_manager_task = asyncio.create_task(self._stream_manager(), name="bq_stream_manager")

    async def stop(self):
        """
        Graceful shutdown.
        Waits for buffers to drain and closes the stream properly.
        """

        logger.info("Stopping BigQueryStreamer... Starting graceful shutdown.")
        self._is_running = False
        
        # 1. Drain the Batch Worker
        # Wait for the worker to finish processing the current queue
        if self._worker_task:
            try:
                # We expect the worker to exit its loop because _is_running is False.
                # However, it might be stuck in wait_for() or queue.get().
                # We let it finish its current iteration or timeout logic.
                await asyncio.wait_for(self._worker_task, timeout=self.flush_interval + 2.0)
            except (asyncio.TimeoutError, asyncio.CancelledError):
                logger.warning("Worker task did not finish in time, cancelling...")
                self._worker_task.cancel()
            except Exception as e:
                logger.error(f"Error waiting for worker task: {e}")

        # 2. Drain the Request Queue (Send Sentinel)
        # Signal the stream manager that no more requests are coming
        await self._request_queue.put(None)
        
        # 3. Wait for Stream Manager to close
        if self._stream_manager_task:
            try:
                await asyncio.wait_for(self._stream_manager_task, timeout=10.0)
            except asyncio.TimeoutError:
                logger.warning("Stream manager timed out during shutdown, cancelling...")
                self._stream_manager_task.cancel()
            except Exception as e:
                logger.error(f"Error waiting for stream manager: {e}")

        logger.info("BigQueryStreamer stopped.")

    async def stream_row(self, data: dict[str, Any]):
        """
        Adds a row to the buffer. Non-blocking (unless queue is full).
        """
        if not self._is_running:
            logger.warning("Attempted to add row to stopped streamer")
            return 
            
        try:
            # If queue is full, this will wait (backpressure)
            await self._queue.put(data)
        except Exception as e:
            logger.error(f"Failed to add row to streamer buffer: {e}")
            raise

    async def _batch_worker(self):
        """
        Collects rows from queue and sends them to the request queue as batches.
        """
        batch = []
        last_flush_time = time.time()

        # Run while running OR while there are items left in the queue during shutdown
        while self._is_running or not self._queue.empty():
            try:
                # Calculate time to wait
                now = time.time()
                time_since_flush = now - last_flush_time
                wait_time = max(0.0, self.flush_interval - time_since_flush)
                
                try:
                    # Wait for next item or timeout
                    if self._is_running:
                         item = await asyncio.wait_for(self._queue.get(), timeout=wait_time)
                    else:
                         # During shutdown, don't wait, just drain
                         item = self._queue.get_nowait()
                         
                    batch.append(item)
                    self._queue.task_done()
                except asyncio.TimeoutError:
                    # Timeout reached, time to flush what we have
                    pass
                except asyncio.QueueEmpty:
                    # Queue empty during shutdown
                    if not self._is_running and batch:
                        pass # proceed to flush
                    elif not self._is_running:
                        break # Done draining
                
                # Try to fill up the batch without waiting if we have items
                while len(batch) < self.max_batch_size:
                    try:
                        item = self._queue.get_nowait()
                        batch.append(item)
                        self._queue.task_done()
                    except asyncio.QueueEmpty:
                        break
                
                # If we have data, send it
                if batch:
                    try:
                        await self._send_batch(batch)
                        logger.debug(f"📦 Queued batch of {len(batch)} rows")
                    except asyncio.CancelledError:
                         logger.warning(f"CancelledError: flushing {len(batch)} remaining rows")
                         # Try to send one last time if cancelled
                         await self._send_batch(batch)
                         break
                    
                    batch = []
                    last_flush_time = time.time()
                
            except asyncio.CancelledError:
                break
            except Exception as e:
                logger.error(f"Error in batch worker: {e}")
                await asyncio.sleep(1)

    async def _send_batch(self, batch: list[dict[str, Any]]):
        """Prepares a request and puts it in the outbound queue."""
        try:
            table_ref = TableReference.from_string(self.table_path)
            stream_name = f"{table_ref.path}/streams/_default".lstrip("/")
            
            request = _build_batch_append_request(stream_name, batch)
            await self._request_queue.put(request)
        except Exception as e:
            logger.error(f"Failed to build batch request: {e}")
            # TODO: Send to DLQ

    async def _stream_manager(self):
        """
        Manages the persistent gRPC stream.
        Re-opens stream on errors.
        Handles graceful shutdown via Sentinel (None).
        """
        while self._is_running or not self._request_queue.empty():
            try:
                # Generator for the client
                async def request_generator():
                    while True:
                        req = await self._request_queue.get()
                        if req is None:
                            # Sentinel received: End of stream
                            return
                        yield req
                        self._request_queue.task_done()

                # Check if we are just shutting down and queue is empty (except maybe sentinel)
                if not self._is_running and self._request_queue.empty():
                     break

                logger.info("Opening new BQ Write Stream...")
                
                # Start the bidirectional stream
                responses = await self.client.append_rows(
                    request_generator(),
                    retry=AsyncRetry()
                )
                
                # Process responses (acks)
                async for response in responses:
                    if response.error.code:
                        logger.error(f"Stream response error: {response.error.message}")
                    else:
                         # Success
                         # logger.debug(f"✅ Batch written, offset: {response.append_result.offset}")
                         pass
                
                # If we get here, the stream finished normally (e.g. generator returned)
                if not self._is_running:
                    logger.info("Stream closed gracefully.")
                    break
                        
            except asyncio.CancelledError:
                break
            except Exception as e:
                logger.error(f"Stream connection lost: {e}. Reconnecting in 2s...")
                if self._is_running:
                    await asyncio.sleep(2)
                else:
                    break


def _build_batch_append_request(
    stream_name: str,
    batch_data: list[dict[str, Any]],
) -> AppendRowsRequest:
    """Build AppendRowsRequest for multiple rows."""
    proto_rows = ProtoRows()

    for data in batch_data:
        try:
            serialized_row = ParseDict(data, StreamingMessage()).SerializeToString()
            proto_rows.serialized_rows.append(serialized_row)
        except Exception as e:
            logger.error(f"Error serializing row in batch: {e}", extra={"data": data})
            continue

    if not proto_rows.serialized_rows:
        raise ValueError("No valid rows to send in batch")

    return AppendRowsRequest(
        write_stream=stream_name,
        proto_rows=AppendRowsRequest.ProtoData(
            rows=proto_rows,
            writer_schema=_PROTO_SCHEMA,
        ),
    )
