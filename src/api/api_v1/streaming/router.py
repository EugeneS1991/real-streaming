from fastapi import APIRouter, Depends
from src.api.api_v1.streaming.schemas import DataToInsert, RequestData
from src.api.api_v1.streaming.dependencies import request_handler
from src.log_config import logger
from src.storage.bigquery.client import get_streaming_service
from src.storage.bigquery.writers.base import StreamerProtocol


router = APIRouter()


@router.post("/{stream_id}")
async def streaming(
    data: RequestData | None = Depends(request_handler),
    streamer: StreamerProtocol = Depends(get_streaming_service),
):
    """
    Accepts streaming data and sends it to BigQuery.
    Cookie is now set by GTM template on the client side.
    """
    
    # 1. Prepare Data
    data_to_insert: DataToInsert = DataToInsert.model_validate(data.model_dump())
    
    # 2. Stream to BigQuery
    try:
        await streamer.stream_row(data=data_to_insert.model_dump())
    except Exception as e:
        logger.error(f"Failed to queue data for BigQuery: {e}", extra={"data": data_to_insert.model_dump()})
    
    return {"status": "ok"}
