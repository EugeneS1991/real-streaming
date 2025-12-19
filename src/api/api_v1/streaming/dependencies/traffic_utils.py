from urllib.parse import urlparse, parse_qsl
from publicsuffix2 import get_sld
from src.api.api_v1.streaming.schemas import CollectedTrafficSource, EventParams
from src.core.config import settings

# Cache internal domains (SLD) list for fast lookup
INTERNAL_DOMAINS = {
    get_sld(urlparse(origin).hostname)
    for origin in settings.cors.allowed_origins
    if urlparse(origin).hostname
}

class TrafficSourceParser:
    """Parser for extracting raw traffic source data using Waterfall/Coalesce logic."""

    @staticmethod
    def _get_hostname(url: str | None) -> str | None:
        if not url:
            return None
        return urlparse(url).hostname

    @staticmethod
    def _get_valid_referrer_host(referrer_url: str | None, current_url: str | None) -> str | None:
        """
        Returns referrer host ONLY if it's external.
        If referrer is internal or empty - returns None.
        """
        if not referrer_url:
            return None

        ref_host = urlparse(referrer_url).hostname
        if not ref_host:
            return None

        # Check for internal traffic
        # 1. Compare SLD (google.com == www.google.com)
        ref_sld = get_sld(ref_host)
        current_sld = get_sld(urlparse(current_url).hostname) if current_url else None

        if current_sld and ref_sld == current_sld:
            return None  # Internal navigation

        # 2. Compare with project's whitelist of domains
        if ref_sld in INTERNAL_DOMAINS:
            return None  # Internal navigation

        return ref_host

    @staticmethod
    def parse(event_params: list[EventParams] | None) -> CollectedTrafficSource:
        if not event_params:
            return CollectedTrafficSource()

        page_location: str | None = None
        page_referrer: str | None = None

        # 1. Extract raw data
        for item in event_params:
            if item.key == "page_location":
                page_location = item.value.string_value
            elif item.key == "page_referrer":
                page_referrer = item.value.string_value

        # 2. Parse query parameters (UTM, gclid...)
        query_params: dict[str, str] = {}
        if page_location:
            parsed_loc = urlparse(page_location)
            query_params = dict(parse_qsl(parsed_loc.query))

        # --- CANDIDATE PREPARATION ---
        
        # Candidates from UTM
        utm_source = query_params.get("utm_source")
        utm_medium = query_params.get("utm_medium")
        
        # Candidate from Referrer (will be None if referrer is internal)
        referrer_host = TrafficSourceParser._get_valid_referrer_host(page_referrer, page_location)

        # --- COALESCE (WATERFALL) LOGIC ---

        # 1. Determine SOURCE
        # SQL: COALESCE(utm_source, referrer_host, None)
        final_source = utm_source or referrer_host or None

        # 2. Determine MEDIUM
        # SQL: COALESCE(utm_medium, "referral" IF final_source ELSE NULL, None)
        # If utm_medium exists - use it (highest priority).
        # If no utm_medium, but Source exists (any source) - set "referral".
        # If no source at all (direct visit) - medium is also None.
        if utm_medium:
            final_medium = utm_medium
        elif final_source:
            final_medium = "referral"
        else:
            final_medium = None

        # --- ASSEMBLY ---
        return CollectedTrafficSource(
            manual_source=final_source,
            manual_medium=final_medium,
            
            # Other parameters parsed "as is" (coalesce not needed, just get)
            manual_campaign_id=query_params.get("utm_id") or None,
            manual_campaign_name=query_params.get("utm_campaign") or None,
            manual_term=query_params.get("utm_term") or None,
            manual_content=query_params.get("utm_content") or None,
            manual_source_platform=query_params.get("utm_source_platform") or None,
            manual_creative_format=query_params.get("utm_creative_format") or None,
            manual_marketing_tactic=query_params.get("utm_marketing_tactic") or None,
            gclid=query_params.get("gclid") or None,
            dclid=query_params.get("dclid") or None,
            srsltid=query_params.get("srsltid") or None,
            fbclid=query_params.get("fbclid") or None,
        )