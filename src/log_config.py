import logging
import sys
from src.core.config import settings

logger = logging.getLogger("stream-api")
logger.setLevel(logging.DEBUG)

formatter = logging.Formatter(
    datefmt="%Y-%m-%d %H:%M:%S",
    fmt="%(levelname)-9s %(asctime)s.%(msecs)03d - %(module)-10s - %(funcName)s:%(lineno)-10d - %(message)s - [%(pathname)s]",
)

if not logger.hasHandlers():
    if settings.environment == "QA":
        handler = logging.StreamHandler(sys.stdout)
        handler.setFormatter(formatter)
        logger.addHandler(handler)
    else:
        from google.cloud import logging as cloud_logging
        client = cloud_logging.Client()
        client.setup_logging(log_level=logging.DEBUG)
        # Cloud Logging will add handler automatically
