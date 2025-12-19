from fastapi import Response
from src.core.config import settings

async def set_streaming_cookies(response: Response, user_pseudo_id: str, domain: str | None) -> None:
    """
    Sets the analytics identification cookie.
    Handles domain logic (localhost vs production).
    """
    # Explicit content type setting, if critical for your frontend/client
    response.media_type = "application/json"

    cookie_params = {
        "max_age": settings.cookie.max_age,
        "secure": settings.cookie.secure,
        "httponly": settings.cookie.httponly,
        "samesite": settings.cookie.samesite,
    }

    # If domain is defined (we're not on localhost/IP), add it to parameters
    if domain:
        cookie_params["domain"] = domain
    
    response.set_cookie(
        key="__uid__", 
        value=user_pseudo_id, 
        **cookie_params
    )