import json
from typing import Any
from concurrent import futures
from google.cloud import pubsub_v1
from src.core.config import settings
from src.log_config import logger
from src.storage.bigquery.writers.base import StreamerProtocol

class PubSubStreamer(StreamerProtocol):
    """
    Simple Pub/Sub streamer relying on native client batching.
    Uses Google Pub/Sub PublisherClient internal batching mechanism.
    """

    def __init__(self):
        self.project_id = settings.writers.project_id
        # Topic name is derived from table_id. Ensure this topic exists!
        self.topic_id = settings.writers.pubsub.topic_id

        # Configure native batching
        # Publisher will hold messages until one of these thresholds is met:
        batch_settings = pubsub_v1.types.BatchSettings(
            max_messages=settings.writers.pubsub.max_batch_size,  # e.g., 500
            max_bytes=settings.writers.pubsub.max_bytes,  # 1 MB
            max_latency=settings.writers.pubsub.flush_interval,  # e.g., 0.5s
        )

        self.publisher = pubsub_v1.PublisherClient(batch_settings=batch_settings)
        self.topic_path = self.publisher.topic_path(self.project_id, self.topic_id)

        logger.info(
            f"PubSubStreamer initialized for {self.topic_path}. "
            f"Batch settings: {settings.writers.pubsub.max_batch_size} msgs, {settings.writers.pubsub.flush_interval}s latency"
        )

    # Lifecycle stubs for compatibility with BigQueryStreamer interface
    async def start(self):
        """No background workers needed, client handles batching."""
        pass

    async def stop(self):
        # Shutdown the publisher properly
        self.publisher.stop()

    async def stream_row(self, data: dict[str, Any]):
        """
        Asynchronously publish a message.
        Returns immediately (non-blocking). Failures are logged via callback.
        """
        try:
            # Serialize to JSON
            data_str = json.dumps(data)
            data_bytes = data_str.encode("utf-8")

            # Publish (returns Future immediately)
            future = self.publisher.publish(self.topic_path, data_bytes)

            # Add callback for error logging (fire-and-forget)
            future.add_done_callback(self._get_callback(data_str))

        except Exception as e:
            logger.error(f"Failed to schedule publish: {e}")

    def _get_callback(self, data_preview: str):
        def callback(future):
            try:
                future.result(timeout=10)  # Check result, throws exception on failure
            except Exception as e:
                # Log only if failed
                logger.error(f"PubSub publish failed: {e}. Data sample: {data_preview[:100]}...")

        return callback

