from contextlib import asynccontextmanager
from fastapi import FastAPI
from starlette_context import middleware, plugins
from brotli_asgi import BrotliMiddleware
from fastapi.middleware.cors import CORSMiddleware
from src.api import router as api_router
from src.storage.bigquery.client import get_streaming_service
from src.storage.bigquery import table
from src.log_config import logger
from src.core.config import settings

@asynccontextmanager
async def lifespan(app: FastAPI):
    """
    Application lifespan manager.
    """
    # === STARTUP ===
    logger.info("Application starting...")

    # 1. Infrastructure Setup (One-liner now)
    # Checks and creates table if needed. Handles its own connection.
    table.ensure_table()
    
    # 2. Get the singleton instance. 
    # Since it's an async dependency in FastAPI context but a sync function in helper,
    # we can just call it directly since it returns the object.
    streaming_service = await get_streaming_service()

    
    # Start the background streamer
    await streaming_service.start()
    
    logger.info("Application started successfully")
    
    yield
    
    # === SHUTDOWN ===
    logger.info("Application shutting down...")
    
    # 3. Gracefully dispose the SAME instance
    await streaming_service.stop()
    
    logger.info("Application stopped")


main_app = FastAPI(
    lifespan=lifespan,
    title="MyStream",
)


main_app.add_middleware(
    middleware.RawContextMiddleware,
    plugins=(plugins.ForwardedForPlugin(),),
)


main_app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.cors.allowed_origins,
    allow_credentials=settings.cors.allow_credentials,
    allow_methods=settings.cors.allow_methods,
    allow_headers=settings.cors.allow_headers,
)


main_app.add_middleware(
    BrotliMiddleware,
    quality=4,
    lgwin=22,
    lgblock=0,
    minimum_size=100,
    gzip_fallback=True,
)


main_app.include_router(api_router)
