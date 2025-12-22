from fastapi import Request, Response, Header, Cookie
from src.core.config import settings
from tldextract import extract


async def get_cookie_domain(
    request: Request,
) -> str | None:
    """
    Extract registered domain from Host header for cookie domain setting.
    Works like Google Analytics - cookie available on all subdomains.
    
    Examples:
        www.example.com -> example.com
        api.subdomain.example.com -> example.com
        localhost:8000 -> None (local development)
    """
    host=request.headers.get("host")
    extracted=extract(host).registered_domain
    domain=extracted if extracted else None
    return domain


async def set_streaming_cookies(
    request: Request, 
    response: Response, 
    user_pseudo_id: str,
    ) -> None:
    """
    Sets the analytics identification cookie.
    Handles domain logic (localhost vs production).
    """
    # Explicit content type setting, if critical for your frontend/client
    response.media_type = "application/json"
    domain=await get_cookie_domain(request)
    cookie_params = {
        "domain": domain,
        "max_age": settings.cookie.max_age,
        "secure": settings.cookie.secure,
        "httponly": settings.cookie.httponly,
        "samesite": settings.cookie.samesite,
    }
    
    response.set_cookie(
        key="__uid__", 
        value=user_pseudo_id, 
        **cookie_params
    )