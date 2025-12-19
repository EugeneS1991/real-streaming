from fastapi import APIRouter
from src.api.api_v1 import router as router_api_v1
from src.core.config import settings

router = APIRouter()

router.include_router(router_api_v1, prefix=settings.api.prefix)
