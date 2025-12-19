# src/storage/protocol.py
from typing import Protocol, Any, Dict

class StreamerProtocol(Protocol):
    """
    Protocol defining the interface for any streaming implementation.
    """
    async def start(self) -> None:
        """Start background tasks or connections."""
        ...

    async def stop(self) -> None:
        """Gracefully stop background tasks and flush buffers."""
        ...

    async def stream_row(self, data: Dict[str, Any]) -> None:
        """Send a single row of data to the storage."""
        ...