from google.cloud.bigquery_storage_v1.services.big_query_write.async_client import (
    BigQueryWriteAsyncClient,
)

from src.core.config import settings
from src.core.constants import StreamingStrategy
from src.storage.bigquery.writers.base import StreamerProtocol
from src.storage.bigquery.writers.direct import DirectStreamer
from src.storage.bigquery.writers.pubsub import PubSubStreamer
from src.log_config import logger


# === Internal Factory Logic ===

def _create_service() -> StreamerProtocol:
    strategy = settings.writers.strategy
    logger.info(f"Initializing Streaming Strategy: {strategy}")

    if strategy == StreamingStrategy.PUBSUB:
        return PubSubStreamer()
    
    # Default: BigQuery Direct Streaming
    client = BigQueryWriteAsyncClient()
    return DirectStreamer(client=client)


# === SINGLETON INSTANCE ===
# Created once when this file is imported
# This is an analog of bq_helper_instance = BigQueryHelper() from old code
# client.py

_service_instance: StreamerProtocol | None = None  # <-- Declaration only

async def get_streaming_service() -> StreamerProtocol:
    global _service_instance
    if _service_instance is None:  # <-- Created only on first call
        _service_instance = _create_service()
    return _service_instance