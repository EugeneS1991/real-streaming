from fastapi import APIRouter, Response, Depends, Header
from src.api.api_v1.streaming.schemas import DataToInsert, RequestData
# Cookie setting moved to GTM template - no longer needed on backend
# from src.api.api_v1.streaming.dependencies import request_handler, get_cookie_domain
from src.api.api_v1.streaming.dependencies import request_handler
from src.log_config import logger
# Cookie setting moved to GTM template - no longer needed on backend
# from src.api.api_v1.streaming.cookies import set_streaming_cookies 
from src.storage.bigquery.client import get_streaming_service
from src.storage.bigquery.writers.base import StreamerProtocol
from src.core.config import settings

router = APIRouter()


@router.post("/{stream_id}")
async def streaming(
    response: Response,
    # Cookie setting moved to GTM template - domain extraction no longer needed
    # domain: str | None = Depends(get_cookie_domain),
    data: RequestData | None = Depends(request_handler),
    streamer: StreamerProtocol = Depends(get_streaming_service),
):
    """
    Accepts streaming data and sends it to BigQuery.
    Cookie is now set by GTM template on the client side.
    """
    
    # 1. Prepare Data
    data_to_insert: DataToInsert = DataToInsert.model_validate(data.model_dump())
    
    # Cookie setting moved to GTM template - no longer set on backend
    # The __uid__ cookie is now set by the GTM template when the page loads
    # await set_streaming_cookies(response, data.user_pseudo_id, domain)

    # 2. Stream to BigQuery
    try:
        await streamer.stream_row(data=data_to_insert.model_dump())
    except Exception as e:
        logger.error(f"Failed to queue data for BigQuery: {e}", extra={"data": data_to_insert.model_dump()})
    
    return {"status": "ok"}
