from google.protobuf.internal import containers as _containers
from google.protobuf import descriptor as _descriptor
from google.protobuf import message as _message
from typing import ClassVar as _ClassVar, Iterable as _Iterable, Mapping as _Mapping, Optional as _Optional, Union as _Union

DESCRIPTOR: _descriptor.FileDescriptor

class StreamingMessage(_message.Message):
    __slots__ = ["date", "event_timestamp", "event_name", "event_params", "user_id", "user_pseudo_id", "privacy_info", "user_properties", "device", "geo", "app_info", "collected_traffic_source", "stream_id", "ecommerce", "items", "ip", "event_id", "synced_at_micros_", "subscription_name", "message_id", "publish_time", "attributes"]
    class Value(_message.Message):
        __slots__ = ["string_value", "int_value", "float_value"]
        STRING_VALUE_FIELD_NUMBER: _ClassVar[int]
        INT_VALUE_FIELD_NUMBER: _ClassVar[int]
        FLOAT_VALUE_FIELD_NUMBER: _ClassVar[int]
        string_value: str
        int_value: int
        float_value: float
        def __init__(self, string_value: _Optional[str] = ..., int_value: _Optional[int] = ..., float_value: _Optional[float] = ...) -> None: ...
    class Event_params(_message.Message):
        __slots__ = ["key", "value"]
        KEY_FIELD_NUMBER: _ClassVar[int]
        VALUE_FIELD_NUMBER: _ClassVar[int]
        key: str
        value: StreamingMessage.Value
        def __init__(self, key: _Optional[str] = ..., value: _Optional[_Union[StreamingMessage.Value, _Mapping]] = ...) -> None: ...
    class Privacy_info(_message.Message):
        __slots__ = ["ad_storage", "ad_user_data", "ad_personalization", "analytics_storage", "functionality_storage", "personalization_storage", "security_storage"]
        AD_STORAGE_FIELD_NUMBER: _ClassVar[int]
        AD_USER_DATA_FIELD_NUMBER: _ClassVar[int]
        AD_PERSONALIZATION_FIELD_NUMBER: _ClassVar[int]
        ANALYTICS_STORAGE_FIELD_NUMBER: _ClassVar[int]
        FUNCTIONALITY_STORAGE_FIELD_NUMBER: _ClassVar[int]
        PERSONALIZATION_STORAGE_FIELD_NUMBER: _ClassVar[int]
        SECURITY_STORAGE_FIELD_NUMBER: _ClassVar[int]
        ad_storage: bool
        ad_user_data: bool
        ad_personalization: bool
        analytics_storage: bool
        functionality_storage: bool
        personalization_storage: bool
        security_storage: bool
        def __init__(self, ad_storage: bool = ..., ad_user_data: bool = ..., ad_personalization: bool = ..., analytics_storage: bool = ..., functionality_storage: bool = ..., personalization_storage: bool = ..., security_storage: bool = ...) -> None: ...
    class Value1(_message.Message):
        __slots__ = ["string_value", "int_value", "float_value", "set_timestamp_micros"]
        STRING_VALUE_FIELD_NUMBER: _ClassVar[int]
        INT_VALUE_FIELD_NUMBER: _ClassVar[int]
        FLOAT_VALUE_FIELD_NUMBER: _ClassVar[int]
        SET_TIMESTAMP_MICROS_FIELD_NUMBER: _ClassVar[int]
        string_value: str
        int_value: int
        float_value: float
        set_timestamp_micros: int
        def __init__(self, string_value: _Optional[str] = ..., int_value: _Optional[int] = ..., float_value: _Optional[float] = ..., set_timestamp_micros: _Optional[int] = ...) -> None: ...
    class User_properties(_message.Message):
        __slots__ = ["key", "value"]
        KEY_FIELD_NUMBER: _ClassVar[int]
        VALUE_FIELD_NUMBER: _ClassVar[int]
        key: str
        value: StreamingMessage.Value1
        def __init__(self, key: _Optional[str] = ..., value: _Optional[_Union[StreamingMessage.Value1, _Mapping]] = ...) -> None: ...
    class Web_info(_message.Message):
        __slots__ = ["browser", "browser_version"]
        BROWSER_FIELD_NUMBER: _ClassVar[int]
        BROWSER_VERSION_FIELD_NUMBER: _ClassVar[int]
        browser: str
        browser_version: str
        def __init__(self, browser: _Optional[str] = ..., browser_version: _Optional[str] = ...) -> None: ...
    class Device(_message.Message):
        __slots__ = ["category", "mobile_brand_name", "mobile_model_name", "mobile_marketing_name", "mobile_os_hardware_model", "operating_system", "operating_system_version", "vendor_id", "advertising_id", "language", "is_limited_ad_tracking", "web_info", "is_bot", "user_agent"]
        CATEGORY_FIELD_NUMBER: _ClassVar[int]
        MOBILE_BRAND_NAME_FIELD_NUMBER: _ClassVar[int]
        MOBILE_MODEL_NAME_FIELD_NUMBER: _ClassVar[int]
        MOBILE_MARKETING_NAME_FIELD_NUMBER: _ClassVar[int]
        MOBILE_OS_HARDWARE_MODEL_FIELD_NUMBER: _ClassVar[int]
        OPERATING_SYSTEM_FIELD_NUMBER: _ClassVar[int]
        OPERATING_SYSTEM_VERSION_FIELD_NUMBER: _ClassVar[int]
        VENDOR_ID_FIELD_NUMBER: _ClassVar[int]
        ADVERTISING_ID_FIELD_NUMBER: _ClassVar[int]
        LANGUAGE_FIELD_NUMBER: _ClassVar[int]
        IS_LIMITED_AD_TRACKING_FIELD_NUMBER: _ClassVar[int]
        WEB_INFO_FIELD_NUMBER: _ClassVar[int]
        IS_BOT_FIELD_NUMBER: _ClassVar[int]
        USER_AGENT_FIELD_NUMBER: _ClassVar[int]
        category: str
        mobile_brand_name: str
        mobile_model_name: str
        mobile_marketing_name: str
        mobile_os_hardware_model: str
        operating_system: str
        operating_system_version: str
        vendor_id: str
        advertising_id: str
        language: str
        is_limited_ad_tracking: str
        web_info: StreamingMessage.Web_info
        is_bot: bool
        user_agent: str
        def __init__(self, category: _Optional[str] = ..., mobile_brand_name: _Optional[str] = ..., mobile_model_name: _Optional[str] = ..., mobile_marketing_name: _Optional[str] = ..., mobile_os_hardware_model: _Optional[str] = ..., operating_system: _Optional[str] = ..., operating_system_version: _Optional[str] = ..., vendor_id: _Optional[str] = ..., advertising_id: _Optional[str] = ..., language: _Optional[str] = ..., is_limited_ad_tracking: _Optional[str] = ..., web_info: _Optional[_Union[StreamingMessage.Web_info, _Mapping]] = ..., is_bot: bool = ..., user_agent: _Optional[str] = ...) -> None: ...
    class Geo(_message.Message):
        __slots__ = ["country", "region", "city"]
        COUNTRY_FIELD_NUMBER: _ClassVar[int]
        REGION_FIELD_NUMBER: _ClassVar[int]
        CITY_FIELD_NUMBER: _ClassVar[int]
        country: str
        region: str
        city: str
        def __init__(self, country: _Optional[str] = ..., region: _Optional[str] = ..., city: _Optional[str] = ...) -> None: ...
    class App_info(_message.Message):
        __slots__ = ["id", "version", "install_store", "firebase_app_id", "install_source"]
        ID_FIELD_NUMBER: _ClassVar[int]
        VERSION_FIELD_NUMBER: _ClassVar[int]
        INSTALL_STORE_FIELD_NUMBER: _ClassVar[int]
        FIREBASE_APP_ID_FIELD_NUMBER: _ClassVar[int]
        INSTALL_SOURCE_FIELD_NUMBER: _ClassVar[int]
        id: str
        version: str
        install_store: str
        firebase_app_id: str
        install_source: str
        def __init__(self, id: _Optional[str] = ..., version: _Optional[str] = ..., install_store: _Optional[str] = ..., firebase_app_id: _Optional[str] = ..., install_source: _Optional[str] = ...) -> None: ...
    class Collected_traffic_source(_message.Message):
        __slots__ = ["manual_source", "manual_medium", "manual_campaign_id", "manual_campaign_name", "manual_term", "manual_content", "manual_source_platform", "manual_creative_format", "manual_marketing_tactic", "gclid", "dclid", "srsltid", "fbclid"]
        MANUAL_SOURCE_FIELD_NUMBER: _ClassVar[int]
        MANUAL_MEDIUM_FIELD_NUMBER: _ClassVar[int]
        MANUAL_CAMPAIGN_ID_FIELD_NUMBER: _ClassVar[int]
        MANUAL_CAMPAIGN_NAME_FIELD_NUMBER: _ClassVar[int]
        MANUAL_TERM_FIELD_NUMBER: _ClassVar[int]
        MANUAL_CONTENT_FIELD_NUMBER: _ClassVar[int]
        MANUAL_SOURCE_PLATFORM_FIELD_NUMBER: _ClassVar[int]
        MANUAL_CREATIVE_FORMAT_FIELD_NUMBER: _ClassVar[int]
        MANUAL_MARKETING_TACTIC_FIELD_NUMBER: _ClassVar[int]
        GCLID_FIELD_NUMBER: _ClassVar[int]
        DCLID_FIELD_NUMBER: _ClassVar[int]
        SRSLTID_FIELD_NUMBER: _ClassVar[int]
        FBCLID_FIELD_NUMBER: _ClassVar[int]
        manual_source: str
        manual_medium: str
        manual_campaign_id: str
        manual_campaign_name: str
        manual_term: str
        manual_content: str
        manual_source_platform: str
        manual_creative_format: str
        manual_marketing_tactic: str
        gclid: str
        dclid: str
        srsltid: str
        fbclid: str
        def __init__(self, manual_source: _Optional[str] = ..., manual_medium: _Optional[str] = ..., manual_campaign_id: _Optional[str] = ..., manual_campaign_name: _Optional[str] = ..., manual_term: _Optional[str] = ..., manual_content: _Optional[str] = ..., manual_source_platform: _Optional[str] = ..., manual_creative_format: _Optional[str] = ..., manual_marketing_tactic: _Optional[str] = ..., gclid: _Optional[str] = ..., dclid: _Optional[str] = ..., srsltid: _Optional[str] = ..., fbclid: _Optional[str] = ...) -> None: ...
    class Ecommerce(_message.Message):
        __slots__ = ["transaction_id", "value", "currency", "coupon", "payment_type", "shipping_tier", "item_list_id", "item_list_name", "promotion_id", "promotion_name", "creative_name", "creative_slot", "total_item_quantity"]
        TRANSACTION_ID_FIELD_NUMBER: _ClassVar[int]
        VALUE_FIELD_NUMBER: _ClassVar[int]
        CURRENCY_FIELD_NUMBER: _ClassVar[int]
        COUPON_FIELD_NUMBER: _ClassVar[int]
        PAYMENT_TYPE_FIELD_NUMBER: _ClassVar[int]
        SHIPPING_TIER_FIELD_NUMBER: _ClassVar[int]
        ITEM_LIST_ID_FIELD_NUMBER: _ClassVar[int]
        ITEM_LIST_NAME_FIELD_NUMBER: _ClassVar[int]
        PROMOTION_ID_FIELD_NUMBER: _ClassVar[int]
        PROMOTION_NAME_FIELD_NUMBER: _ClassVar[int]
        CREATIVE_NAME_FIELD_NUMBER: _ClassVar[int]
        CREATIVE_SLOT_FIELD_NUMBER: _ClassVar[int]
        TOTAL_ITEM_QUANTITY_FIELD_NUMBER: _ClassVar[int]
        transaction_id: str
        value: float
        currency: str
        coupon: str
        payment_type: str
        shipping_tier: str
        item_list_id: str
        item_list_name: str
        promotion_id: str
        promotion_name: str
        creative_name: str
        creative_slot: str
        total_item_quantity: int
        def __init__(self, transaction_id: _Optional[str] = ..., value: _Optional[float] = ..., currency: _Optional[str] = ..., coupon: _Optional[str] = ..., payment_type: _Optional[str] = ..., shipping_tier: _Optional[str] = ..., item_list_id: _Optional[str] = ..., item_list_name: _Optional[str] = ..., promotion_id: _Optional[str] = ..., promotion_name: _Optional[str] = ..., creative_name: _Optional[str] = ..., creative_slot: _Optional[str] = ..., total_item_quantity: _Optional[int] = ...) -> None: ...
    class Items(_message.Message):
        __slots__ = ["item_id", "item_name", "affiliation", "coupon", "discount", "index", "item_brand", "item_category", "item_category2", "item_category3", "item_category4", "item_category5", "item_list_id", "item_list_name", "item_variant", "location_id", "price", "promotion_id", "promotion_name", "creative_name", "creative_slot", "quantity"]
        ITEM_ID_FIELD_NUMBER: _ClassVar[int]
        ITEM_NAME_FIELD_NUMBER: _ClassVar[int]
        AFFILIATION_FIELD_NUMBER: _ClassVar[int]
        COUPON_FIELD_NUMBER: _ClassVar[int]
        DISCOUNT_FIELD_NUMBER: _ClassVar[int]
        INDEX_FIELD_NUMBER: _ClassVar[int]
        ITEM_BRAND_FIELD_NUMBER: _ClassVar[int]
        ITEM_CATEGORY_FIELD_NUMBER: _ClassVar[int]
        ITEM_CATEGORY2_FIELD_NUMBER: _ClassVar[int]
        ITEM_CATEGORY3_FIELD_NUMBER: _ClassVar[int]
        ITEM_CATEGORY4_FIELD_NUMBER: _ClassVar[int]
        ITEM_CATEGORY5_FIELD_NUMBER: _ClassVar[int]
        ITEM_LIST_ID_FIELD_NUMBER: _ClassVar[int]
        ITEM_LIST_NAME_FIELD_NUMBER: _ClassVar[int]
        ITEM_VARIANT_FIELD_NUMBER: _ClassVar[int]
        LOCATION_ID_FIELD_NUMBER: _ClassVar[int]
        PRICE_FIELD_NUMBER: _ClassVar[int]
        PROMOTION_ID_FIELD_NUMBER: _ClassVar[int]
        PROMOTION_NAME_FIELD_NUMBER: _ClassVar[int]
        CREATIVE_NAME_FIELD_NUMBER: _ClassVar[int]
        CREATIVE_SLOT_FIELD_NUMBER: _ClassVar[int]
        QUANTITY_FIELD_NUMBER: _ClassVar[int]
        item_id: str
        item_name: str
        affiliation: str
        coupon: str
        discount: float
        index: int
        item_brand: str
        item_category: str
        item_category2: str
        item_category3: str
        item_category4: str
        item_category5: str
        item_list_id: str
        item_list_name: str
        item_variant: str
        location_id: str
        price: float
        promotion_id: str
        promotion_name: str
        creative_name: str
        creative_slot: str
        quantity: int
        def __init__(self, item_id: _Optional[str] = ..., item_name: _Optional[str] = ..., affiliation: _Optional[str] = ..., coupon: _Optional[str] = ..., discount: _Optional[float] = ..., index: _Optional[int] = ..., item_brand: _Optional[str] = ..., item_category: _Optional[str] = ..., item_category2: _Optional[str] = ..., item_category3: _Optional[str] = ..., item_category4: _Optional[str] = ..., item_category5: _Optional[str] = ..., item_list_id: _Optional[str] = ..., item_list_name: _Optional[str] = ..., item_variant: _Optional[str] = ..., location_id: _Optional[str] = ..., price: _Optional[float] = ..., promotion_id: _Optional[str] = ..., promotion_name: _Optional[str] = ..., creative_name: _Optional[str] = ..., creative_slot: _Optional[str] = ..., quantity: _Optional[int] = ...) -> None: ...
    DATE_FIELD_NUMBER: _ClassVar[int]
    EVENT_TIMESTAMP_FIELD_NUMBER: _ClassVar[int]
    EVENT_NAME_FIELD_NUMBER: _ClassVar[int]
    EVENT_PARAMS_FIELD_NUMBER: _ClassVar[int]
    USER_ID_FIELD_NUMBER: _ClassVar[int]
    USER_PSEUDO_ID_FIELD_NUMBER: _ClassVar[int]
    PRIVACY_INFO_FIELD_NUMBER: _ClassVar[int]
    USER_PROPERTIES_FIELD_NUMBER: _ClassVar[int]
    DEVICE_FIELD_NUMBER: _ClassVar[int]
    GEO_FIELD_NUMBER: _ClassVar[int]
    APP_INFO_FIELD_NUMBER: _ClassVar[int]
    COLLECTED_TRAFFIC_SOURCE_FIELD_NUMBER: _ClassVar[int]
    STREAM_ID_FIELD_NUMBER: _ClassVar[int]
    ECOMMERCE_FIELD_NUMBER: _ClassVar[int]
    ITEMS_FIELD_NUMBER: _ClassVar[int]
    IP_FIELD_NUMBER: _ClassVar[int]
    EVENT_ID_FIELD_NUMBER: _ClassVar[int]
    SYNCED_AT_MICROS__FIELD_NUMBER: _ClassVar[int]
    SUBSCRIPTION_NAME_FIELD_NUMBER: _ClassVar[int]
    MESSAGE_ID_FIELD_NUMBER: _ClassVar[int]
    PUBLISH_TIME_FIELD_NUMBER: _ClassVar[int]
    ATTRIBUTES_FIELD_NUMBER: _ClassVar[int]
    date: str
    event_timestamp: int
    event_name: str
    event_params: _containers.RepeatedCompositeFieldContainer[StreamingMessage.Event_params]
    user_id: str
    user_pseudo_id: str
    privacy_info: StreamingMessage.Privacy_info
    user_properties: _containers.RepeatedCompositeFieldContainer[StreamingMessage.User_properties]
    device: StreamingMessage.Device
    geo: StreamingMessage.Geo
    app_info: StreamingMessage.App_info
    collected_traffic_source: StreamingMessage.Collected_traffic_source
    stream_id: int
    ecommerce: StreamingMessage.Ecommerce
    items: _containers.RepeatedCompositeFieldContainer[StreamingMessage.Items]
    ip: str
    event_id: str
    synced_at_micros_: int
    subscription_name: str
    message_id: str
    publish_time: str
    attributes: str
    def __init__(self, date: _Optional[str] = ..., event_timestamp: _Optional[int] = ..., event_name: _Optional[str] = ..., event_params: _Optional[_Iterable[_Union[StreamingMessage.Event_params, _Mapping]]] = ..., user_id: _Optional[str] = ..., user_pseudo_id: _Optional[str] = ..., privacy_info: _Optional[_Union[StreamingMessage.Privacy_info, _Mapping]] = ..., user_properties: _Optional[_Iterable[_Union[StreamingMessage.User_properties, _Mapping]]] = ..., device: _Optional[_Union[StreamingMessage.Device, _Mapping]] = ..., geo: _Optional[_Union[StreamingMessage.Geo, _Mapping]] = ..., app_info: _Optional[_Union[StreamingMessage.App_info, _Mapping]] = ..., collected_traffic_source: _Optional[_Union[StreamingMessage.Collected_traffic_source, _Mapping]] = ..., stream_id: _Optional[int] = ..., ecommerce: _Optional[_Union[StreamingMessage.Ecommerce, _Mapping]] = ..., items: _Optional[_Iterable[_Union[StreamingMessage.Items, _Mapping]]] = ..., ip: _Optional[str] = ..., event_id: _Optional[str] = ..., synced_at_micros_: _Optional[int] = ..., subscription_name: _Optional[str] = ..., message_id: _Optional[str] = ..., publish_time: _Optional[str] = ..., attributes: _Optional[str] = ...) -> None: ...
