from enum import Enum
# 1. Define Enum for type safety
class StreamingStrategy(str, Enum):
    DIRECT = "direct"   # BigQuery Storage Write API
    PUBSUB = "pubsub"   # Google Pub/Sub