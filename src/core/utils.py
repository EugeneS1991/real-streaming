from datetime import datetime, timezone

def utc_now() -> datetime:
    return datetime.now(timezone.utc)

def utc_timestamp() -> int:
    return int(utc_now().timestamp())

def utc_timestamp_micros() -> int:
    return int(utc_now().timestamp() * 1000000)

def utc_date_str() -> str:
    return str(utc_now().date())