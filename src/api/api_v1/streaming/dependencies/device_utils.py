import asyncio
from concurrent.futures import ThreadPoolExecutor
from typing import NamedTuple
from src.log_config import logger

from device_detector import DeviceDetector

from src.api.api_v1.streaming.schemas import Device, WebInfo


# Thread pool for CPU-bound operations
_executor = ThreadPoolExecutor(max_workers=4)


class ParsedDeviceInfo(NamedTuple):
    """Hashable container for parsed device information."""
    mobile_brand_name: str | None
    mobile_model_name: str | None
    mobile_marketing_name: str | None
    mobile_os_hardware_model: str | None
    operating_system: str | None
    operating_system_version: str | None
    browser: str | None
    browser_version: str | None
    category: str
    is_bot: bool


def _parse_user_agent_sync(user_agent: str) -> ParsedDeviceInfo:
    """
    Parse user agent synchronously.
    Returns hashable NamedTuple for proper caching.
    Uses device_detector (Matomo Device Detector) - most accurate library.
    """
    try:
        detector = DeviceDetector(user_agent).parse()
        
        # Determine device category (order matters: bot check first)
        if detector.is_bot():
            category = "bot"
        elif detector.is_desktop():
            category = "desktop"
        elif detector.is_mobile():
            category = "mobile"
        elif detector.is_tablet():
            category = "tablet"
        elif detector.is_television():
            category = "smart tv"
        else:
            category = "unknown"
        
        # Note: device_detector doesn't distinguish between mobile_model_name,
        # mobile_marketing_name, and mobile_os_hardware_model - all use device_model()
        device_model = detector.device_model()
        
        return ParsedDeviceInfo(
            mobile_brand_name=detector.device_brand(),
            mobile_model_name=device_model,
            mobile_marketing_name=device_model,
            mobile_os_hardware_model=device_model,
            operating_system=detector.os_name(),
            operating_system_version=detector.os_version(),
            browser=detector.client_name(),
            browser_version=detector.client_version(),
            category=category,
            is_bot=bool(detector.is_bot()),
        )
    except Exception as e:
        logger.warning(f"Failed to parse user agent: {e}", extra={"user_agent": user_agent[:100]})
        # Return default values on parsing error
        return ParsedDeviceInfo(
            mobile_brand_name=None,
            mobile_model_name=None,
            mobile_marketing_name=None,
            mobile_os_hardware_model=None,
            operating_system=None,
            operating_system_version=None,
            browser=None,
            browser_version=None,
            category="unknown",
            is_bot=False,
        )


class DeviceParser:
    @staticmethod
    def parse_language(accept_language: str | None) -> str | None:
        """
        Parse Accept-Language header and return primary language.
        Handles quality values (q=) and returns highest priority language.
        """
        if not accept_language:
            return None

        try:
            languages = accept_language.split(",")
            # Parse language with quality value
            locale_q_pairs = []
            for lang in languages:
                parts = lang.split(";")
                locale = parts[0].strip()
                if not locale:
                    continue
                
                # Extract quality value (default 1.0)
                q_value = 1.0
                if len(parts) > 1 and "=" in parts[1]:
                    try:
                        q_value = float(parts[1].split("=")[1].strip())
                    except (ValueError, IndexError):
                        # Invalid q-value format, use default
                        q_value = 1.0
                
                locale_q_pairs.append((locale, q_value))
            
            if not locale_q_pairs:
                return None
            
            # Sort by quality (descending) and return highest priority
            locale_q_pairs.sort(key=lambda x: x[1], reverse=True)
            return locale_q_pairs[0][0]
        except Exception as e:
            logger.warning(f"Failed to parse Accept-Language header: {e}", extra={"accept_language": accept_language})
            # Fallback: return first language without quality parsing
            if accept_language:
                return accept_language.split(",")[0].split(";")[0].strip() or None
            return None

    @staticmethod
    async def parse(
        user_agent: str | None, accept_language: str | None
    ) -> Device:
        """
        Parse user agent and accept language headers to extract device info.
        CPU-bound parsing is offloaded to thread pool to avoid blocking event loop.
        
        Uses device_detector (Matomo Device Detector) - industry standard library
        with excellent accuracy and regular updates.
        """
        if not user_agent:
            return Device()

        # Run CPU-bound parsing in thread pool to avoid blocking event loop
        loop = asyncio.get_running_loop()
        parsed_info = await loop.run_in_executor(
            _executor, _parse_user_agent_sync, user_agent
        )

        language = DeviceParser.parse_language(accept_language)

        return Device(
            category=parsed_info.category,
            mobile_brand_name=parsed_info.mobile_brand_name,
            mobile_model_name=parsed_info.mobile_model_name,
            mobile_marketing_name=parsed_info.mobile_marketing_name,
            mobile_os_hardware_model=parsed_info.mobile_os_hardware_model,
            operating_system=parsed_info.operating_system,
            operating_system_version=parsed_info.operating_system_version,
            language=language,
            web_info=WebInfo(
                browser=parsed_info.browser,
                browser_version=parsed_info.browser_version,
            ),
            is_bot=parsed_info.is_bot,
            user_agent=user_agent,
        )