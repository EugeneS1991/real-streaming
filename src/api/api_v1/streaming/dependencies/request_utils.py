from fastapi import Header, Cookie, Path
from starlette_context import context
from uuid import uuid4

from src.api.api_v1.streaming.schemas import Payload, RequestData, Geo
from src.api.api_v1.streaming.dependencies import DeviceParser, TrafficSourceParser


async def request_handler(
    body: Payload,
    stream_id: int = Path(...),
    uid_cookie: str | None = Cookie(None, alias="__uid__"),
    user_agent: str | None = Header(None),
    accept_language: str | None = Header(None),
    country: str | None = Header(None, alias="x-client-geo-country"),
    region: str | None = Header(None, alias="x-client-geo-state"),
    city: str | None = Header(None, alias="x-client-geo-city"),
) -> RequestData:
    """
    Enrich incoming payload with server-side data for BigQuery.
    Session logic removed - calculated later via OWOX BI Transformation.
    """
    return RequestData(
        **body.model_dump(),
        stream_id=stream_id,
        user_pseudo_id=uid_cookie,
        device=await DeviceParser.parse(user_agent, accept_language),
        geo=Geo(country=country, region=region, city=city),
        collected_traffic_source=TrafficSourceParser.parse(body.event_params),
        ip=context.data.get("X-Forwarded-For"),
    )
