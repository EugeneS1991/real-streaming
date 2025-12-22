from fastapi import APIRouter
from src.core.config import settings
from src.api.api_v1.streaming.router import router as streaming_router
from src.api.api_v1.fetch.router import router as fetch_router

router = APIRouter(prefix=settings.api.v1.prefix)
router.include_router(
    streaming_router,
    tags=["Streaming"],
    prefix=settings.api.v1.streaming,
)

router.include_router(
    fetch_router,
    tags=["FETCH"],
    prefix=settings.api.v1.fetch,
)

## Uncomment to enable local dev routes (not for production)
# from src.api.api_v1.dev.router import router as dev_router
# router.include_router(
#     dev_router,
#     tags=["DEV"],
#     prefix="/dev",
# )