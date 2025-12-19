from pydantic_settings import BaseSettings, SettingsConfigDict
from pydantic import BaseModel
from src.core.constants import StreamingStrategy

class RunConfig(BaseModel):
    host: str = "127.0.0.1"
    port: int = 8000


class ApiV1Prefix(BaseModel):
    prefix: str = "/v1"
    streaming: str = "/streaming"
    fetch: str = "/fetch"


class ApiPrefix(BaseModel):
    prefix: str = "/api"
    v1: ApiV1Prefix = ApiV1Prefix()



class BigQueryWriterConfig(BaseModel):
    """Configuration for BigQuery Direct Streaming writer."""
    dataset_id: str
    table_id: str
    flush_interval: float = 0.5
    max_batch_size: int = 500
    max_queue_size: int = 100000
    
    def table_path(self, project_id: str) -> str:
        """Build table path using project_id from parent WritersConfig."""
        return f"{project_id}.{self.dataset_id}.{self.table_id}"


class PubSubWriterConfig(BaseModel):
    """Configuration for Google Pub/Sub writer."""
    topic_id: str
    subscription_id: str
    max_bytes: int = 1024 * 1024  # 1 MB in bytes
    publish_timeout: float = 10.0  # Timeout for publish callback in seconds
    max_batch_size: int = 500
    flush_interval: float = 0.5



class WritersConfig(BaseModel):
    """Unified configuration for all data writers (BigQuery, PubSub, etc.)."""
    project_id: str  # Common for all writers
    strategy: StreamingStrategy
    bq: BigQueryWriterConfig
    pubsub: PubSubWriterConfig



class CorsConfig(BaseModel):
    allowed_origins: list[str]
    allow_credentials: bool = True
    allow_methods: list[str] = ["GET", "POST", "OPTIONS"]
    allow_headers: list[str] = [
        "Content-Type",
        "Set-Cookie",
        "Access-Control-Allow-Headers",
        "Access-Control-Allow-Origin",
        "Authorization",
    ]

class CookieConfig(BaseModel):
    """Configuration for session/tracking cookies."""
    max_age: int = 63072000  # 2 years in seconds
    secure: bool = True
    httponly: bool = True
    samesite: str = "none"  # "strict", "lax", or "none"



class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        env_file=(
            "src/.env.template",
            "src/.env",

        ),
        case_sensitive=False,
        env_nested_delimiter="__",
        env_prefix="APP_CONFIG__",
    )
    # RunConfig settings
    run: RunConfig = RunConfig()
    # ApiPrefixConfiguration
    api: ApiPrefix = ApiPrefix()
    # BigQuery Settings
    writers: WritersConfig
    environment: str | None = None
    cors: CorsConfig
    cookie: CookieConfig = CookieConfig()


settings = Settings()
