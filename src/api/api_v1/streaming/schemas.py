import json
from pydantic import BaseModel, Field, ConfigDict, model_validator, Json
from datetime import datetime, timezone
from src.core.utils import utc_now, utc_timestamp, utc_timestamp_micros, utc_date_str

class EventParamsValue(BaseModel):
    string_value: str | None = None
    int_value: int | None = None
    float_value: float | None = None


class EventParams(BaseModel):
    key: str | None
    value: EventParamsValue


class PrivacyInfo(BaseModel):
    ad_storage: bool | None
    ad_user_data: bool | None
    ad_personalization: bool | None
    analytics_storage: bool | None
    functionality_storage: bool | None
    personalization_storage: bool | None
    security_storage: bool | None


class WebInfo(BaseModel):
    browser: str | None = None
    browser_version: str | None = None


class Device(BaseModel):
    category: str | None = None
    mobile_brand_name: str | None = None
    mobile_model_name: str | None = None
    mobile_marketing_name: str | None = None
    mobile_os_hardware_model: str | None = None
    operating_system: str | None = None
    operating_system_version: str | None = None
    vendor_id: str | None = None
    advertising_id: str | None = None
    language: str | None = None
    is_limited_ad_tracking: str | None = None
    web_info: WebInfo | None = None
    is_bot: bool | None = None
    user_agent: str | None = None


class Geo(BaseModel):
    country: str | None
    region: str | None
    city: str | None


class AppInfo(BaseModel):
    id: str | None
    firebase_app_id: str | None
    install_source: str | None
    version: str | None


class CollectedTrafficSource(BaseModel):
    """
    Raw collected traffic source data from UTM parameters and referrer.
    Not session-attributed - just parsed values from the request.
    """
    manual_campaign_id: str | None = None
    manual_campaign_name: str | None = None
    manual_source: str | None = None
    manual_medium: str | None = None
    manual_term: str | None = None
    manual_content: str | None = None
    manual_source_platform: str | None = None
    manual_creative_format: str | None = None
    manual_marketing_tactic: str | None = None
    gclid: str | None = None
    dclid: str | None = None
    srsltid: str | None = None
    fbclid: str | None = None


class Items(BaseModel):
    item_id: str | None
    item_name: str | None
    affiliation: str | None
    coupon: str | None
    discount: float | None
    index: int | None
    item_brand: str | None
    item_category: str | None
    item_category2: str | None
    item_category3: str | None
    item_category4: str | None
    item_category5: str | None
    item_list_id: str | None
    item_list_name: str | None
    item_variant: str | None
    location_id: str | None
    price: float | None
    promotion_id: str | None
    promotion_name: str | None
    creative_name: str | None
    creative_slot: str | None
    quantity: int | None


class Ecommerce(BaseModel):
    transaction_id: str | None
    value: float | None
    currency: str | None
    coupon: str | None
    payment_type: str | None
    shipping_tier: str | None
    item_list_id: str | None
    item_list_name: str | None
    promotion_id: str | None
    promotion_name: str | None
    creative_name: str | None
    creative_slot: str | None
    total_item_quantity: int | None


class DataToInsert(BaseModel):
    date: str = Field(default_factory=utc_date_str)
    event_timestamp: int = Field(default_factory=utc_timestamp_micros)
    event_name: str | None
    event_params: list[EventParams] | None
    user_id: str | None
    user_pseudo_id: str 
    privacy_info: PrivacyInfo | None
    user_properties: list[EventParams] | None
    device: Device | None
    geo: Geo | None
    app_info: AppInfo | None
    collected_traffic_source: CollectedTrafficSource | None
    stream_id: int | None
    ecommerce: Ecommerce | None
    items: list[Items] | None
    ip: str | None
    synced_at_utc_: str = Field(default_factory=lambda: utc_now().isoformat())
    synced_at_micros_: int = Field(default_factory=utc_timestamp_micros)
    subscription_name: str | None = None
    message_id: str | None = None
    publish_time: datetime | None = None  # Or str, if BQ expects TIMESTAMP as string
    attributes: Json | None = None    



class Payload(BaseModel):
    """
    Incoming payload from client.
    Fields ordered according to OWOX/GA4 BigQuery schema.
    """
    model_config = ConfigDict(from_attributes=True)
    event_name: str
    event_params: list[EventParams] | None = None
    user_id: str | None = None
    privacy_info: PrivacyInfo | None = None
    user_properties: list[EventParams] | None = None
    app_info: AppInfo | None = None
    ecommerce: Ecommerce | None = None
    items: list[Items] | None = None

    @model_validator(mode="before")
    def destination(cls, value):
        if isinstance(value, bytes):
            return json.loads(value)
        return value


class RequestData(Payload):
    """
    Enriched request data for BigQuery insertion.
    Fields ordered according to OWOX/GA4 BigQuery schema.
    Server-side enriched fields added after client payload fields.
    """
    stream_id: int
    user_pseudo_id: str | None
    device: Device | None
    geo: Geo | None
    collected_traffic_source: CollectedTrafficSource | None
    ip: str | None
