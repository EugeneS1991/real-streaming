from fastapi import APIRouter, Response, Depends, Header
from src.api.api_v1.streaming.schemas import DataToInsert, RequestData
from src.api.api_v1.streaming.dependencies import request_handler, get_cookie_domain
from src.log_config import logger
from src.api.api_v1.streaming.cookies import set_streaming_cookies 
from src.storage.bigquery.client import get_streaming_service
from src.storage.bigquery.writers.base import StreamerProtocol
from src.core.config import settings

router = APIRouter()


@router.post("/{stream_id}")
async def streaming(
    response: Response,
    domain: str | None = Depends(get_cookie_domain),
    data: RequestData | None = Depends(request_handler),
    streamer: StreamerProtocol = Depends(get_streaming_service),
):
    """
    Accepts streaming data and sends it to BigQuery.
    Cookie domain extracted separately for cross-subdomain support (like Google Analytics).
    """
    
    # 1. Prepare Data
    data_to_insert: DataToInsert = DataToInsert.model_validate(data.model_dump())
    
    # 2. Set Cookies (Logic extracted)
    await set_streaming_cookies(response, data.user_pseudo_id, domain)

    # 3. Stream to BigQuery
    try:
        await streamer.stream_row(data=data_to_insert.model_dump())
    except Exception as e:
        logger.error(f"Failed to queue data for BigQuery: {e}", extra={"data": data_to_insert.model_dump()})
    
    return {"status": "ok"}
