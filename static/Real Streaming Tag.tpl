___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_MBTSV",
  "version": 1,
  "displayName": "Real Streaming Tag",
  "categories": [
    "ANALYTICS",
    "CONVERSIONS"
  ],
  "brand": {
    "id": "custom",
    "displayName": "Custom",
    "thumbnail": "my_image"
  },
  "description": "Send analytics events to your streaming backend with automatic user identification and cookie management. Supports real-time data streaming with custom event parameters and user properties.",
  "containerContexts": [
    "WEB"
  ],
  "securityGroups": []
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "stream_id",
    "displayName": "Stream ID",
    "simpleValueType": true,
    "help": "Stream ID to include in the request path. Must be an integer value (e.g., 1, 2, 3). This will be inserted into the URL path.",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "alwaysInSummary": true
  },
  {
    "type": "RADIO",
    "name": "event_type",
    "displayName": "Event Name",
    "radioItems": [
      {
        "value": "standard",
        "displayValue": "Standard",
        "subParams": [
          {
            "type": "SELECT",
            "name": "event_name_standard",
            "selectItems": [
              {
                "value": "page_view",
                "displayValue": "Page View"
              },
              {
                "value": "add_payment_info",
                "displayValue": "Add Payment Info"
              },
              {
                "value": "add_to_cart",
                "displayValue": "Add To Cart"
              },
              {
                "value": "add_to_wishlist",
                "displayValue": "Add To Wishlist"
              },
              {
                "value": "begin_checkout",
                "displayValue": "Begin Checkout"
              },
              {
                "value": "contact",
                "displayValue": "Contact"
              },
              {
                "value": "customize_product",
                "displayValue": "Customize Product"
              },
              {
                "value": "donate",
                "displayValue": "Donate"
              },
              {
                "value": "exception",
                "displayValue": "Exception"
              },
              {
                "value": "find_location",
                "displayValue": "Find Location"
              },
              {
                "value": "generate_lead",
                "displayValue": "Generate Lead"
              },
              {
                "value": "join_group",
                "displayValue": "Join Group"
              },
              {
                "value": "login",
                "displayValue": "Login"
              },
              {
                "value": "purchase",
                "displayValue": "Purchase"
              },
              {
                "value": "refund",
                "displayValue": "Refund"
              },
              {
                "value": "schedule",
                "displayValue": "Schedule"
              },
              {
                "value": "search",
                "displayValue": "Search"
              },
              {
                "value": "select_content",
                "displayValue": "Select Content"
              },
              {
                "value": "share",
                "displayValue": "Share"
              },
              {
                "value": "sign_up",
                "displayValue": "Sign Up"
              },
              {
                "value": "start_trial",
                "displayValue": "Start Trial"
              },
              {
                "value": "submit_application",
                "displayValue": "Submit Application"
              },
              {
                "value": "subscribe",
                "displayValue": "Subscribe"
              },
              {
                "value": "view_item",
                "displayValue": "View Item"
              },
              {
                "value": "view_item_list",
                "displayValue": "View Item List"
              },
              {
                "value": "view_search_results",
                "displayValue": "View Search Results"
              }
            ],
            "simpleValueType": true,
            "defaultValue": "page_view",
            "alwaysInSummary": true
          }
        ]
      },
      {
        "value": "custom",
        "displayValue": "Custom",
        "subParams": [
          {
            "type": "TEXT",
            "name": "event_name_custom",
            "simpleValueType": true
          }
        ]
      }
    ],
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "gtm_server_domain",
    "displayName": "Server URL",
    "simpleValueType": true,
    "help": "Domain to where the tag will send requests.\u003cbr\u003eFor example: \u003ci\u003ehttps://example.com\u003c/i\u003e",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "alwaysInSummary": true
  },
  {
    "type": "CHECKBOX",
    "name": "add_data_layer",
    "checkboxText": "Send all from DataLayer",
    "simpleValueType": true,
    "help": "Adds all Data Layer values to the request."
  },
  {
    "type": "CHECKBOX",
    "name": "add_common",
    "checkboxText": "Send common data",
    "simpleValueType": true,
    "help": "Adds to request:\n\u003cul\u003e\n\u003cli\u003epage_location\u003c/li\u003e\n\u003cli\u003epage_path\u003c/li\u003e\n\u003cli\u003epage_hostname\u003c/li\u003e\n\u003cli\u003epage_referrer\u003c/li\u003e\n\u003cli\u003epage_title\u003c/li\u003e\n\u003cli\u003epage_encoding\u003c/li\u003e\n\u003cli\u003escreen_resolution\u003c/li\u003e\n\u003cli\u003eviewport_size\u003c/li\u003e\n\u003c/ul\u003e",
    "defaultValue": true
  },
  {
    "type": "CHECKBOX",
    "name": "add_consent_state",
    "checkboxText": "Add consent state",
    "simpleValueType": true,
    "help": "Adds \u003cb\u003econsent_state\u003c/b\u003e object to request.\u003cbr/\u003e\nIncluding following properties:\u003cbr/\u003e \nad_storage\u003cbr/\u003e\nad_user_data\u003cbr/\u003e\nad_personalization\u003cbr/\u003e\nanalytics_storage\u003cbr/\u003e\nfunctionality_storage\u003cbr/\u003e\npersonalization_storage\u003cbr/\u003e\nsecurity_storage"
  },
  {
    "type": "CHECKBOX",
    "name": "add_common_cookie",
    "checkboxText": "Add Common Cookie",
    "simpleValueType": true,
    "help": "The tag will send common cookies in \u003cI\u003eeventData\u003c/i\u003e to avoid some e-commerce platform limitations."
  },
  {
    "type": "GROUP",
    "name": "custom",
    "displayName": "Event Data",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "SIMPLE_TABLE",
        "name": "custom_data",
        "displayName": "",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Name",
            "name": "name",
            "type": "TEXT",
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ]
          },
          {
            "defaultValue": "",
            "displayName": "Value",
            "name": "value",
            "type": "TEXT"
          },
          {
            "defaultValue": "none",
            "displayName": "Transformation",
            "name": "transformation",
            "type": "SELECT",
            "selectItems": [
              {
                "value": "none",
                "displayValue": "None"
              },
              {
                "value": "trim",
                "displayValue": "Trim"
              },
              {
                "value": "to_lower_case",
                "displayValue": "To lower case"
              },
              {
                "value": "md5",
                "displayValue": "MD5 hash"
              },
              {
                "value": "base64",
                "displayValue": "Base64"
              },
              {
                "value": "sha256base64",
                "displayValue": "SHA-256 digest (Base64 encoded)"
              },
              {
                "value": "sha256hex",
                "displayValue": "SHA-256 digest (HEX encoded)"
              }
            ],
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ]
          },
          {
            "defaultValue": "none",
            "displayName": "Store",
            "name": "store",
            "type": "SELECT",
            "selectItems": [
              {
                "value": "none",
                "displayValue": "None"
              },
              {
                "value": "all",
                "displayValue": "Everywhere"
              },
              {
                "value": "localStorage",
                "displayValue": "Local Storage"
              },
              {
                "value": "cookies",
                "displayValue": "Cookies"
              }
            ],
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ]
          }
        ]
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "user",
    "displayName": "User Data",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "SIMPLE_TABLE",
        "name": "user_data",
        "displayName": "",
        "simpleTableColumns": [
          {
            "defaultValue": "email_address",
            "displayName": "Name",
            "name": "name",
            "type": "SELECT",
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ],
            "isUnique": true,
            "selectItems": [
              {
                "value": "email_address",
                "displayValue": "Email Address"
              },
              {
                "value": "phone_number",
                "displayValue": "Phone Number"
              },
              {
                "value": "first_name",
                "displayValue": "First Name"
              },
              {
                "value": "last_name",
                "displayValue": "Last Name"
              },
              {
                "value": "gender",
                "displayValue": "Gender"
              },
              {
                "value": "db",
                "displayValue": "Date of Birth"
              },
              {
                "value": "street",
                "displayValue": "Street"
              },
              {
                "value": "city",
                "displayValue": "City"
              },
              {
                "value": "region",
                "displayValue": "Region"
              },
              {
                "value": "postal_code",
                "displayValue": "Postal Code"
              },
              {
                "value": "country",
                "displayValue": "Country"
              },
              {
                "value": "user_id",
                "displayValue": "User ID"
              }
            ]
          },
          {
            "defaultValue": "",
            "displayName": "Value",
            "name": "value",
            "type": "TEXT"
          },
          {
            "defaultValue": "none",
            "displayName": "Transformation",
            "name": "transformation",
            "type": "SELECT",
            "selectItems": [
              {
                "value": "none",
                "displayValue": "None"
              },
              {
                "value": "trim",
                "displayValue": "Trim"
              },
              {
                "value": "to_lower_case",
                "displayValue": "To lower case"
              },
              {
                "value": "md5",
                "displayValue": "MD5 hash"
              },
              {
                "value": "base64",
                "displayValue": "Base64"
              },
              {
                "value": "sha256base64",
                "displayValue": "SHA-256 digest (Base64 encoded)"
              },
              {
                "value": "sha256hex",
                "displayValue": "SHA-256 digest (HEX encoded)"
              }
            ],
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ]
          },
          {
            "defaultValue": "none",
            "displayName": "Store",
            "name": "store",
            "type": "SELECT",
            "selectItems": [
              {
                "value": "none",
                "displayValue": "None"
              },
              {
                "value": "all",
                "displayValue": "Everywhere"
              },
              {
                "value": "localStorage",
                "displayValue": "Local Storage"
              },
              {
                "value": "cookies",
                "displayValue": "Cookies"
              }
            ],
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ]
          }
        ]
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "settings",
    "displayName": "Settings",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "SELECT",
        "name": "request_type",
        "displayName": "Request type",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "post",
            "displayValue": "POST"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "post",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "help": "Currently only POST requests are supported. GET support will be added in the future."
      },
      {
        "type": "TEXT",
        "name": "protocol_version",
        "displayName": "Protocol version",
        "simpleValueType": true,
        "defaultValue": 2,
        "help": "Protocol version that used for sending a request to the streaming backend.",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "data_tag_load_script_url",
        "displayName": "Data Tag Script URL",
        "simpleValueType": true,
        "help": "\u003cb\u003eIMPORTANT:\u003c/b\u003e Replace \u003ci\u003eyour_domain_name\u003c/i\u003e with your actual server domain (the same as in Server URL field).\u003cbr/\u003eExample: If your server is \u003ci\u003ehttps://example.com\u003c/i\u003e, use \u003ci\u003ehttps://example.com/api/v1/fetch/v6.js\u003c/i\u003e",
        "valueValidators": [
          {
            "type": "REGEX",
            "args": [
              "^(https://|http://).*(\\.js)$"
            ],
            "errorMessage": "URL must start with https:// or http:// and end with .js"
          }
        ],
        "alwaysInSummary": false,
        "defaultValue": "https://storage.googleapis.com/inject_script/inject/v6.js"
      },
      {
        "type": "CHECKBOX",
        "name": "addGaParameters",
        "checkboxText": "Add GA4 specific parameters",
        "simpleValueType": true,
        "help": "Adds specific parameters for the server GA4 tag.",
        "defaultValue": false,
        "enablingConditions": [
          {
            "paramName": "request_type",
            "paramValue": "post",
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "gaId",
        "displayName": "Measurement ID",
        "simpleValueType": true,
        "enablingConditions": [
          {
            "paramName": "addGaParameters",
            "paramValue": true,
            "type": "EQUALS"
          }
        ],
        "valueHint": "G-ABCD123456",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "help": "Enter the Measurement ID of your GA4 property."
      },
      {
        "type": "CHECKBOX",
        "name": "dataLayerEventPush",
        "checkboxText": "Push event to DataLayer after tag receives a response",
        "simpleValueType": true,
        "help": "Helpful in obtaining data from the server.",
        "defaultValue": false
      },
      {
        "type": "TEXT",
        "name": "dataLayerEventName",
        "displayName": "DataLayer Event Name",
        "simpleValueType": true,
        "enablingConditions": [
          {
            "paramName": "dataLayerEventPush",
            "paramValue": true,
            "type": "EQUALS"
          }
        ],
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "valueHint": "page_view_response"
      },
      {
        "type": "TEXT",
        "name": "dataLayerVariableName",
        "displayName": "DataLayer Object Name",
        "simpleValueType": true,
        "enablingConditions": [
          {
            "paramName": "dataLayerEventPush",
            "paramValue": true,
            "type": "EQUALS"
          }
        ],
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "defaultValue": "dataLayer",
        "help": "Use \u003ci\u003edataLayer\u003c/i\u003e by default. Modify only if you renamed dataLayer object name."
      },
      {
        "type": "CHECKBOX",
        "name": "richsstsse",
        "checkboxText": "Support rich command protocol",
        "simpleValueType": true,
        "enablingConditions": [
          {
            "paramName": "request_type",
            "paramValue": "get",
            "type": "NOT_EQUALS"
          }
        ],
        "help": "Useful if you have server-side tags, that (partially) depend on the \u003cI\u003esendPixelFromBrowser()\u003c/i\u003e API for 3rd party cookies (e.g. Google Ads Conversion, Google Ads Remarketing).",
        "defaultValue": false
      },
      {
        "type": "CHECKBOX",
        "name": "waitForCookies",
        "checkboxText": "Wait for cookies before event is pushed",
        "simpleValueType": true,
        "defaultValue": false,
        "enablingConditions": [
          {
            "paramName": "richsstsse",
            "paramValue": true,
            "type": "EQUALS"
          }
        ],
        "help": "Wait for all cookies to be set before event is pushed to DataLayer. Helpful if a server-side tag sets cookies that a web tag relies on."
      },
      {
        "type": "CHECKBOX",
        "name": "useFetchInsteadOfXHR",
        "checkboxText": "Use fetch instead of XMLHttpRequest (for POST requests only)",
        "simpleValueType": true,
        "help": "Using \u003ci\u003efetch\u003c/i\u003e with \u003ci\u003ekeepalive\u003c/i\u003e option which allow the request to outlive the page. \u003ca href\u003d\"https://developer.mozilla.org/en-US/docs/Web/API/fetch#keepalive\"\u003eRead more\u003c/a\u003e.",
        "defaultValue": true
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const copyFromDataLayer = require('copyFromDataLayer');
const JSON = require('JSON');
const getUrl = require('getUrl');
const getReferrerUrl = require('getReferrerUrl');
const readTitle = require('readTitle');
const injectScript = require('injectScript');
const callInWindow = require('callInWindow');
const makeNumber = require('makeNumber');
const readCharacterSet = require('readCharacterSet');
const localStorage = require('localStorage');
const sendPixel = require('sendPixel');
const encodeUriComponent = require('encodeUriComponent');
const toBase64 = require('toBase64');
const makeString = require('makeString');
const setCookie = require('setCookie');
const getCookieValues = require('getCookieValues');
const getContainerVersion = require('getContainerVersion');
const isConsentGranted = require('isConsentGranted');
const getTimestampMillis = require('getTimestampMillis');
const generateRandom = require('generateRandom');
const copyFromWindow = require('copyFromWindow');
const setInWindow = require('setInWindow');

let pageLocation = getUrl();

if (
  pageLocation &&
  pageLocation.lastIndexOf('https://gtm-msr.appspot.com/', 0) === 0
) {
  data.gtmOnSuccess();

  return;
}

// Ensure __uid__ cookie is set
ensureUidCookie();

const userAndCustomData = getUserAndCustomDataArray();
let requestType = determinateRequestType();

const normalizedServerUrl = normalizeServerUrl();

if (requestType === 'post') {
  const dataTagScriptUrl = data.data_tag_load_script_url || 'https://storage.googleapis.com/inject_script/inject/v6.js';
  injectScript(
    dataTagScriptUrl,
    sendPostRequest,
    data.gtmOnFailure,
    dataTagScriptUrl
  );
} else {
  sendGetRequest();
}

// Extract stream_id from parameter or URL
function extractStreamId() {
  // First try to get from template parameter
  if (data.stream_id) {
    return makeString(data.stream_id);
  }
  
  // Try to extract from current URL
  const url = getUrl();
  const streamingIndex = url.indexOf('/streaming/');
  if (streamingIndex !== -1) {
    const startPos = streamingIndex + 11; // length of '/streaming/'
    const endPos = url.indexOf('/', startPos);
    const streamIdStr = endPos !== -1 ? url.substring(startPos, endPos) : url.substring(startPos);
    if (streamIdStr && streamIdStr.length > 0) {
      const streamIdNum = makeNumber(streamIdStr);
      // Check if it's a valid number by comparing with original string
      if (streamIdNum !== 0 || streamIdStr === '0') {
        return makeString(streamIdNum);
      }
    }
  }
  
  // Try to get from dataLayer
  const streamIdFromDataLayer = copyFromDataLayer('stream_id');
  if (streamIdFromDataLayer) {
    return makeString(streamIdFromDataLayer);
  }
  
  return null;
}

// Build request path with stream_id
function buildRequestPath(streamId) {
  let requestPath = normalizedServerUrl.requestPath;
  
  if (streamId) {
    // Remove trailing slash if present, then append stream_id
    if (requestPath.charAt(requestPath.length - 1) === '/') {
      requestPath = requestPath + streamId;
    } else {
      requestPath = requestPath + '/' + streamId;
    }
  }
  
  return requestPath;
}

// Convert value to EventParamsValue format
function convertToEventParamsValue(value) {
  const valueStr = makeString(value);
  const valueNum = makeNumber(value);

  const result = {};

  // Determine type and set appropriate field
  // Try to determine if it's a number by checking if makeNumber returns valid number
  const trimmedStr = valueStr.trim();
  const numStr = makeString(valueNum);
  
  // Check if the trimmed string matches the number string representation
  // This indicates it's a valid number
  let isNumber = false;
  if (trimmedStr === numStr) {
    isNumber = true;
  } else if (valueNum === 0 && (trimmedStr === '0' || trimmedStr === '0.0')) {
    isNumber = true;
  } else if (valueNum !== 0 && trimmedStr === numStr) {
    isNumber = true;
  }
  
  // Additional check: manually check if string contains only digits and optional decimal point
  if (!isNumber && trimmedStr.length > 0) {
    let hasOnlyDigits = true;
    let hasDecimalPoint = false;
    let startIndex = 0;
    
    // Check for negative sign
    if (trimmedStr.charAt(0) === '-') {
      startIndex = 1;
    }
    
    // Check each character
    for (let i = startIndex; i < trimmedStr.length; i++) {
      const char = trimmedStr.charAt(i);
      if (char === '.') {
        if (hasDecimalPoint) {
          hasOnlyDigits = false;
          break;
        }
        hasDecimalPoint = true;
      } else if (char < '0' || char > '9') {
        hasOnlyDigits = false;
        break;
      }
    }
    
    if (hasOnlyDigits) {
      isNumber = true;
    }
  }

  if (isNumber) {
    // It's a number - check if it's integer or float
    const hasDecimal = trimmedStr.indexOf('.') !== -1;
    if (hasDecimal) {
      // Float - convert string to float using makeNumber
      const floatValue = makeNumber(trimmedStr);
      result.float_value = floatValue;
    } else {
      // Integer
      result.int_value = valueNum;
    }
  } else {
    // String
    result.string_value = valueStr;
  }

  return result;
}

// Build event_params array: [{key: str, value: {string_value, int_value, float_value}}]
function buildEventParamsArray(data) {
  const eventParams = [];
  const customData = getCustomData(data, true);

  for (let key in customData) {
    const item = customData[key];
    if (item.name && item.value !== undefined && item.value !== null && item.value !== '') {
      const paramValue = convertToEventParamsValue(item.value);
      eventParams.push({
        key: item.name,
        value: paramValue
      });
    }
  }

  // Add common data as event_params if needed
  if (data.add_common || data.add_data_layer) {
    let dataTagData = null;
    
    // Get dataTagData once if needed
    if (data.add_data_layer || data.add_common) {
      // dataTagGetData may not be available yet, so check result
      dataTagData = callInWindow(
        'dataTagGetData',
        getContainerVersion()['containerId']
      );
      // If callInWindow returns undefined, set to null
      if (dataTagData === undefined) {
        dataTagData = null;
      }
    }

    if (data.add_data_layer && dataTagData && dataTagData.dataModel) {
      for (let dataKey in dataTagData.dataModel) {
        if (dataTagData.dataModel[dataKey] !== undefined && dataTagData.dataModel[dataKey] !== null) {
          const paramValue = convertToEventParamsValue(dataTagData.dataModel[dataKey]);
          eventParams.push({
            key: dataKey,
            value: paramValue
          });
        }
      }
    }

    if (data.add_common) {
      const commonData = addCommonData(data, {});
      for (let key in commonData) {
        if (commonData[key] !== undefined && commonData[key] !== null) {
          const paramValue = convertToEventParamsValue(commonData[key]);
          eventParams.push({
            key: key,
            value: paramValue
          });
        }
      }

      // Add screen_resolution and viewport_size if add_common is enabled
      if (dataTagData) {
        if (dataTagData.screen) {
          const screenRes = dataTagData.screen.width + 'x' + dataTagData.screen.height;
          eventParams.push({
            key: 'screen_resolution',
            value: convertToEventParamsValue(screenRes)
          });
        }
        if (dataTagData.innerWidth && dataTagData.innerHeight) {
          const viewportSize = dataTagData.innerWidth + 'x' + dataTagData.innerHeight;
          eventParams.push({
            key: 'viewport_size',
            value: convertToEventParamsValue(viewportSize)
          });
        }
      }
    }
  }

  return eventParams.length > 0 ? eventParams : null;
}

// Build user_properties array: [{key: str, value: {string_value, int_value, float_value}}]
function buildUserPropertiesArray(data) {
  const userProperties = [];
  
  if (data.user_data && data.user_data.length) {
    for (let userDataKey in data.user_data) {
      const item = data.user_data[userDataKey];
      if (item.name && item.value !== undefined && item.value !== null && item.value !== '') {
        // Include user_id in user_properties as well as on top level
        const paramValue = convertToEventParamsValue(item.value);
        userProperties.push({
          key: item.name,
          value: paramValue
        });
      }
    }
  }

  return userProperties.length > 0 ? userProperties : null;
}

// Build privacy_info object
function buildPrivacyInfo() {
  return {
    ad_storage: isConsentGranted('ad_storage'),
    ad_user_data: isConsentGranted('ad_user_data'),
    ad_personalization: isConsentGranted('ad_personalization'),
    analytics_storage: isConsentGranted('analytics_storage'),
    functionality_storage: isConsentGranted('functionality_storage'),
    personalization_storage: isConsentGranted('personalization_storage'),
    security_storage: isConsentGranted('security_storage')
  };
}

// Build payload according to Payload schema
function buildPayloadSchema(streamId) {
  let payload = {
    event_name: getEventName(data),
    v: makeNumber(data.protocol_version),
    event_id: generateUniqueEventId() // Automatically generate and include unique event ID
  };

  // Build event_params array
  payload.event_params = buildEventParamsArray(data);

  // Build user_properties array
  payload.user_properties = buildUserPropertiesArray(data);

  // Build privacy_info object
  if (data.add_consent_state) {
    payload.privacy_info = buildPrivacyInfo();
  }

  // Extract user_id from user_data
  const userData = getUserAndCustomDataArray();
  let userIdEntry = null;
  for (let i = 0; i < userData.length; i++) {
    if (userData[i].name === 'user_id') {
      userIdEntry = userData[i];
      break;
    }
  }
  
  if (userIdEntry && userIdEntry.value) {
    payload.user_id = userIdEntry.value;
  }

  // Add common cookie if needed (not in Payload schema, but useful for server-side processing)
  if (data.add_common_cookie) {
    payload = addCommonCookie(payload);
  }

  // Add temp client ID (not in Payload schema, but useful for tracking)
  payload = addTempClientId(payload);

  // Add GA specific parameters if needed
  payload = addGaRequiredData(data, payload);

  return payload;
}

function sendPostRequest() {
  // Extract stream_id from parameter or URL
  const streamId = extractStreamId();
  
  // Validate stream_id
  if (!streamId) {
    data.gtmOnFailure();
    return;
  }
  
  // Build payload according to Payload schema
  const payload = buildPayloadSchema(streamId);
  
  // Build request path with stream_id
  const requestPathWithStreamId = buildRequestPath(streamId);

  callInWindow(
    'dataTagSendData',
    payload,
    normalizedServerUrl.gtmServerDomain,
    requestPathWithStreamId,
    data.dataLayerEventName,
    data.dataLayerVariableName,
    data.waitForCookies,
    data.useFetchInsteadOfXHR
  );

  data.gtmOnSuccess();
}

function sendGetRequest() {
  // Extract stream_id from parameter or URL
  const streamId = extractStreamId();
  
  // Validate stream_id
  if (!streamId) {
    data.gtmOnFailure();
    return;
  }
  
  // Build endpoint with stream_id
  const endpoint = buildEndpoint(streamId);
  
  sendPixel(
    addDataForGetRequest(data, endpoint),
    data.gtmOnSuccess,
    data.gtmOnFailure
  );
}

function normalizeServerUrl() {
  let gtmServerDomain = data.gtm_server_domain;
  // Hardcoded path - cannot be changed by user
  const requestPath = '/api/v1/streaming/';

  // Add 'https://' if gtmServerDomain doesn't start with it
  if (gtmServerDomain.indexOf('http://') !== 0 && gtmServerDomain.indexOf('https://') !== 0) {
    gtmServerDomain = 'https://' + gtmServerDomain;
  }

  // Removes trailing slash from gtmServerDomain if it ends with it
  if (gtmServerDomain.charAt(gtmServerDomain.length - 1) === '/') {
    gtmServerDomain = gtmServerDomain.slice(0, -1);
  }

  return {
    gtmServerDomain: gtmServerDomain,
    requestPath: requestPath
  };
}

function buildEndpoint(streamId) {
  const requestPath = streamId ? buildRequestPath(streamId) : normalizedServerUrl.requestPath;
  return normalizedServerUrl.gtmServerDomain + requestPath;
}

function addRequiredDataForPostRequest(data, eventData) {
  eventData.event_name = getEventName(data);
  eventData.v = makeNumber(data.protocol_version);

  let customData = getCustomData(data, true);

  for (let key in customData) {
    eventData[customData[key].name] = customData[key].value;
  }

  eventData = addTempClientId(eventData);

  return eventData;
}

function addGaRequiredData(data, eventData) {
  if (data.addGaParameters && data.gaId) {
    eventData['x-ga-measurement_id'] = data.gaId;
    eventData['x-ga-page_id'] = copyFromDataLayer('gtm.start');
    eventData['x-ga-mp2-richsstsse'] = '';
    eventData['x-ga-mp2-seg'] = 1;
    eventData['x-ga-request_count'] = 1;
    eventData['x-ga-protocol_version'] = 2;
    eventData.v = 2;
  }

  return eventData;
}

function addDataForGetRequest(data, url) {
  let eventData = {};
  url +=
    '?v=' +
    data.protocol_version +
    '&event=' +
    encodeUriComponent(getEventName(data));

  if (data.add_common) {
    eventData = addCommonData(data, eventData);
  }

  if (data.add_consent_state) {
    eventData = addConsentStateData(eventData);
  }

  if (data.add_common_cookie) {
    eventData = addCommonCookie(eventData);
  }

  let customData = getCustomData(data, false);

  if (customData.length) {
    for (let customDataKey in customData) {
      eventData[customData[customDataKey].name] =
        customData[customDataKey].value;
    }
  }

  eventData = addTempClientId(eventData);

  if (data.request_type === 'auto') {
    return (
      url + '&dtdc=' + encodeUriComponent(toBase64(JSON.stringify(eventData)))
    );
  }

  for (let eventDataKey in eventData) {
    url +=
      '&' +
      eventDataKey +
      '=' +
      (eventData[eventDataKey]
        ? encodeUriComponent(eventData[eventDataKey])
        : '');
  }

  return url;
}

function addCommonDataForPostRequest(data, eventData) {
  if (data.add_common || data.add_data_layer) {
    const dataTagData = callInWindow(
      'dataTagGetData',
      getContainerVersion()['containerId']
    );

    if (data.add_data_layer && dataTagData.dataModel) {
      for (let dataKey in dataTagData.dataModel) {
        eventData[dataKey] = dataTagData.dataModel[dataKey];
      }
    }

    if (data.add_common) {
      eventData = addCommonData(data, eventData);
      eventData.screen_resolution =
        dataTagData.screen.width + 'x' + dataTagData.screen.height;
      eventData.viewport_size =
        dataTagData.innerWidth + 'x' + dataTagData.innerHeight;
    }
  }
  if (data.add_consent_state) {
    eventData = addConsentStateData(eventData);
  }

  if (data.add_common_cookie) {
    eventData = addCommonCookie(eventData);
  }

  return eventData;
}

function addCommonData(data, eventData) {
  eventData.page_location = getUrl();
  eventData.page_hostname = getUrl('host');
  eventData.page_referrer = getReferrerUrl();
  eventData.page_title = readTitle();
  eventData.page_encoding = readCharacterSet();

  return eventData;
}

function addConsentStateData(eventData) {
  eventData.consent_state = {
    ad_storage: isConsentGranted('ad_storage'),
    ad_user_data: isConsentGranted('ad_user_data'),
    ad_personalization: isConsentGranted('ad_personalization'),
    analytics_storage: isConsentGranted('analytics_storage'),
    functionality_storage: isConsentGranted('functionality_storage'),
    personalization_storage: isConsentGranted('personalization_storage'),
    security_storage: isConsentGranted('security_storage'),
  };
  return eventData;
}

// Helper functions for unique event ID generation
function getGtmUniqueEventId() {
    let gtmId = copyFromDataLayer('gtm.uniqueEventId')  || 0;
    return gtmId >= 0 ? gtmId : '00';
}

function getBrowserId() {
    let gtmBrowserId =  copyFromWindow('gtmBrowserId');

    if (!gtmBrowserId) {
        gtmBrowserId = getTimestampMillis() + generateRandom(100000, 999999);
        setInWindow('gtmBrowserId', gtmBrowserId, false);
    }

    return gtmBrowserId;
}

function getPageLoadId() {
  let eventId = copyFromWindow('gtmPageLoadId');

  if (!eventId) {
    eventId = getTimestampMillis() + generateRandom(100000, 999999);
    setInWindow('gtmPageLoadId', eventId, false);
  }

  return eventId;
}

// Generate unique event ID
function generateUniqueEventId() {
  return getBrowserId() + '_' + getPageLoadId() + getGtmUniqueEventId();
}

// Generate UUID v4-like identifier
function generateUuid() {
  // Format: timestamp.random1.random2.random3
  // Similar to UUID but simpler for GTM sandboxed JS
  return getTimestampMillis() + 
    '.' + 
    generateRandom(100000000, 999999999) + 
    '.' + 
    generateRandom(100000000, 999999999) + 
    '.' + 
    generateRandom(100000000, 999999999);
}

// Ensure __uid__ cookie is set (2 years, sameSite: none, secure: true)
function ensureUidCookie() {
  const uidCookie = getCookieValues('__uid__')[0];
  
  if (!uidCookie) {
    const newUid = generateUuid();
    setCookie('__uid__', newUid, {
      'max-age': 63072000, // 2 years in seconds
      'secure': true,
      'sameSite': 'none',
      'domain': 'auto',
      'path': '/'
    });
  }
}

function addTempClientId(eventData) {
  const tempClientIdStorageKey = 'gtm_dataTagTempClientId';
  const tempClientId = copyFromWindow(tempClientIdStorageKey) || 
    'dcid.1.' +
    getTimestampMillis() +
    '.' +
    generateRandom(100000000, 999999999);
  
  eventData._dcid_temp = tempClientId;
  setInWindow(tempClientIdStorageKey, eventData._dcid_temp);

  return eventData;
}

function getEventName(data) {
  const eventName = 'page_view';

  if (data.event_type === 'standard') {
    return data.event_name_standard ? data.event_name_standard : eventName;
  }

  if (data.event_type === 'custom') {
    return data.event_name_custom ? data.event_name_custom : eventName;
  }

  return eventName;
}

function getCustomData(data, dtagLoaded) {
  let dataToStore = [];
  let customData = userAndCustomData;

  for (let dataKey in customData) {
    let dataValue = customData[dataKey].value;
    let dataTransformation = customData[dataKey].transformation;

    if (dataValue) {
      if (dataTransformation === 'trim') {
        dataValue = makeString(dataValue);
        dataValue = dataValue.trim();
      }

      if (dataTransformation === 'to_lower_case') {
        dataValue = makeString(dataValue);
        dataValue = dataValue.trim().toLowerCase();
      }

      if (dataTransformation === 'base64') {
        dataValue = makeString(dataValue);
        dataValue = toBase64(dataValue);
      }

      if (dtagLoaded && dataTransformation === 'md5') {
        dataValue = makeString(dataValue);
        dataValue = callInWindow('dataTagMD5', dataValue.trim().toLowerCase());
      }

      if (dtagLoaded && dataTransformation === 'sha256base64') {
        dataValue = makeString(dataValue);
        dataValue = callInWindow(
          'dataTag256',
          dataValue.trim().toLowerCase(),
          'B64'
        );
      }

      if (dtagLoaded && dataTransformation === 'sha256hex') {
        dataValue = makeString(dataValue);
        dataValue = callInWindow(
          'dataTag256',
          dataValue.trim().toLowerCase(),
          'HEX'
        );
      }

      if (customData[dataKey].store && customData[dataKey].store !== 'none') {
        dataToStore.push({
          store: customData[dataKey].store,
          name: customData[dataKey].name,
          value: dataValue,
        });
      }

      customData[dataKey].value = dataValue;
    }
  }

  if (dataToStore.length !== 0) {
    storeData(dataToStore);
  }

  return customData;
}

function storeData(dataToStore) {
  let dataToStoreCookieResult = {};
  let dataToStoreLocalStorageResult = {};
  let dataToStoreCookie = getCookieValues('my_streaming')[0];

  if (dataToStoreCookie) {
    dataToStoreCookie = JSON.parse(dataToStoreCookie);

    if (dataToStoreCookie) {
      for (let attrName in dataToStoreCookie) {
        if (dataToStoreCookie[attrName])
          dataToStoreCookieResult[attrName] = dataToStoreCookie[attrName];
      }
    }
  }

  if (localStorage) {
    let dataToStoreLocalStorage = localStorage.getItem('my_streaming');

    if (dataToStoreLocalStorage) {
      dataToStoreLocalStorage = JSON.parse(dataToStoreLocalStorage);

      if (dataToStoreLocalStorage) {
        for (let attrName in dataToStoreLocalStorage) {
          if (dataToStoreLocalStorage[attrName])
            dataToStoreLocalStorageResult[attrName] =
              dataToStoreLocalStorage[attrName];
        }
      }
    }
  }

  for (let attrName in dataToStore) {
    if (dataToStore[attrName].value) {
      if (
        dataToStore[attrName].store === 'all' ||
        dataToStore[attrName].store === 'localStorage'
      ) {
        dataToStoreLocalStorageResult[dataToStore[attrName].name] =
          dataToStore[attrName].value;
      }

      if (
        dataToStore[attrName].store === 'all' ||
        dataToStore[attrName].store === 'cookies'
      ) {
        dataToStoreCookieResult[dataToStore[attrName].name] =
          dataToStore[attrName].value;
      }
    }
  }

  if (localStorage && getObjectLength(dataToStoreLocalStorageResult) !== 0) {
    localStorage.setItem(
      'my_streaming',
      JSON.stringify(dataToStoreLocalStorageResult)
    );
  }

  if (getObjectLength(dataToStoreCookieResult) !== 0) {
    setCookie('my_streaming', JSON.stringify(dataToStoreCookieResult), {
      secure: true,
      domain: 'auto',
      path: '/',
    });
  }
}

function getObjectLength(object) {
  let length = 0;

  for (let key in object) {
    if (object.hasOwnProperty(key)) {
      ++length;
    }
  }
  return length;
}

function determinateRequestType() {
  if (data.request_type !== 'auto') {
    return data.request_type;
  }

  if (data.add_data_layer) {
    return 'post';
  }

  if (data.dataLayerEventPush) {
    return 'post';
  }

  if (data.richsstsse) {
    return 'post';
  }

  const isHashingEnabled = userAndCustomData.some(
    (item) =>
      item.transformation === 'md5' ||
      item.transformation === 'sha256base64' ||
      item.transformation === 'sha256hex'
  );

  if (isHashingEnabled) return 'post';

  const userAndCustomDataLength = makeNumber(
    JSON.stringify(userAndCustomData).length
  );
  return userAndCustomDataLength > 1500 ? 'post' : 'get';
}

function getUserAndCustomDataArray() {
  let userAndCustomDataArray = [];

  if (data.custom_data && data.custom_data.length) {
    userAndCustomDataArray = data.custom_data;
  }

  if (data.user_data && data.user_data.length) {
    for (let userDataKey in data.user_data) {
      userAndCustomDataArray.push(data.user_data[userDataKey]);
    }
  }
  return userAndCustomDataArray;
}

function addCommonCookie(eventData) {
  const cookieNames = [
    // FB cookies
    '_fbc',
    '_fbp',
    '_gtmeec',
    // TikTok cookies
    'ttclid',
    '_ttp',
    // Pinterest cookies
    '_epik',
    // Snapchat cookies
    '_scid',
    '_scclid',
    // Taboola cookies
    'taboola_cid',
    // Awin cookies
    'awin_awc',
    'awin_sn_awc',
    'awin_source',
    // Rakuten cookies
    'rakuten_site_id',
    'rakuten_time_entered',
    'rakuten_ran_mid',
    'rakuten_ran_eaid',
    'rakuten_ran_site_id',
    // Klaviyo cookies
    'klaviyo_email',
    'klaviyo_kx',
    'klaviyo_viewed_items',
    // Outbrain cookies
    'outbrain_cid',
    // Webgains cookies
    'wg_cid',
    // Postscript cookies
    'ps_id',
    // Microsoft UET CAPI cookies
    'uet_msclkid', '_uetmsclkid',
    'uet_vid', '_uetvid'
  ];
  let commonCookie = null;

  for (var i = 0; i < cookieNames.length; i++) {
    const name = cookieNames[i];
    var cookie = getCookieValues(name)[0];
    if (cookie) {
      commonCookie = commonCookie || {};
      commonCookie[name] = cookie;
    }
  }
  if (commonCookie) {
    eventData.common_cookie = commonCookie;
  }
  return eventData;
}


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "dataLayer"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "dataTagSendData"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "dataTagGetData"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "dataTagData"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "dataTagMD5"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "dataTag256"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "gtm_dataTagTempClientId"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "gtmBrowserId"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "gtmPageLoadId"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_referrer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urlParts",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queriesAllowed",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedKeys",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "gtm.uniqueEventId"
              },
              {
                "type": 1,
                "string": "gtm.start"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_title",
        "versionId": "1"
      },
      "param": []
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_url",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urlParts",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queriesAllowed",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://storage.googleapis.com/inject_script/inject/*"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_local_storage",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "my_streaming"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_character_set",
        "versionId": "1"
      },
      "param": []
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "send_pixel",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedUrls",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "cookieAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "cookieNames",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "__uid__"
              },
              {
                "type": 1,
                "string": "my_streaming"
              },
              {
                "type": 1,
                "string": "_fbc"
              },
              {
                "type": 1,
                "string": "_fbp"
              },
              {
                "type": 1,
                "string": "_gtmeec"
              },
              {
                "type": 1,
                "string": "ttclid"
              },
              {
                "type": 1,
                "string": "_ttp"
              },
              {
                "type": 1,
                "string": "_epik"
              },
              {
                "type": 1,
                "string": "_scid"
              },
              {
                "type": 1,
                "string": "_scclid"
              },
              {
                "type": 1,
                "string": "taboola_cid"
              },
              {
                "type": 1,
                "string": "awin_awc"
              },
              {
                "type": 1,
                "string": "awin_sn_awc"
              },
              {
                "type": 1,
                "string": "awin_source"
              },
              {
                "type": 1,
                "string": "rakuten_site_id"
              },
              {
                "type": 1,
                "string": "rakuten_time_entered"
              },
              {
                "type": 1,
                "string": "rakuten_ran_mid"
              },
              {
                "type": 1,
                "string": "rakuten_ran_eaid"
              },
              {
                "type": 1,
                "string": "rakuten_ran_site_id"
              },
              {
                "type": 1,
                "string": "klaviyo_email"
              },
              {
                "type": 1,
                "string": "klaviyo_kx"
              },
              {
                "type": 1,
                "string": "klaviyo_viewed_items"
              },
              {
                "type": 1,
                "string": "outbrain_cid"
              },
              {
                "type": 1,
                "string": "wg_cid"
              },
              {
                "type": 1,
                "string": "ps_id"
              },
              {
                "type": 1,
                "string": "uet_msclkid"
              },
              {
                "type": 1,
                "string": "_uetmsclkid"
              },
              {
                "type": 1,
                "string": "uet_vid"
              },
              {
                "type": 1,
                "string": "_uetvid"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "set_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedCookies",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "name"
                  },
                  {
                    "type": 1,
                    "string": "domain"
                  },
                  {
                    "type": 1,
                    "string": "path"
                  },
                  {
                    "type": 1,
                    "string": "secure"
                  },
                  {
                    "type": 1,
                    "string": "session"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "my_streaming"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "name"
                  },
                  {
                    "type": 1,
                    "string": "domain"
                  },
                  {
                    "type": 1,
                    "string": "path"
                  },
                  {
                    "type": 1,
                    "string": "secure"
                  },
                  {
                    "type": 1,
                    "string": "session"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "__uid__"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_container_data",
        "versionId": "1"
      },
      "param": []
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_consent",
        "versionId": "1"
      },
      "param": [
        {
          "key": "consentTypes",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_user_data"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_personalization"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "analytics_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "functionality_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "personalization_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "security_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: GTM Server Side URL and Request Path for GET requests are normalized
  code: "mockData.request_type = 'get';\nmockData.event_type = 'standard';\nmockData.event_name_standard\
    \ = 'page_view';\n\n[\n  { gtm_server_domain: 'example.com', request_path: '/foo',\
    \ expectedServerUrl: 'https://example.com/foo' },\n  { gtm_server_domain: 'example.com/',\
    \ request_path: '/foo', expectedServerUrl: 'https://example.com/foo' },\n  { gtm_server_domain:\
    \ 'https://example.com', request_path: '/foo', expectedServerUrl: 'https://example.com/foo'\
    \ },\n  { gtm_server_domain: 'https://example.com/', request_path: '/foo', expectedServerUrl:\
    \ 'https://example.com/foo' },\n  { gtm_server_domain: 'example.com', request_path:\
    \ 'foo/', expectedServerUrl: 'https://example.com/foo' },\n  { gtm_server_domain:\
    \ 'example.com/', request_path: 'foo/', expectedServerUrl: 'https://example.com/foo'\
    \ },\n  { gtm_server_domain: 'https://example.com', request_path: 'foo/', expectedServerUrl:\
    \ 'https://example.com/foo' },\n  { gtm_server_domain: 'https://example.com/',\
    \ request_path: 'foo/', expectedServerUrl: 'https://example.com/foo' },\n  { gtm_server_domain:\
    \ 'http://example.com', request_path: '/foo', expectedServerUrl: 'http://example.com/foo'\
    \ },\n  { gtm_server_domain: 'http://example.com/', request_path: '/foo', expectedServerUrl:\
    \ 'http://example.com/foo' },\n  { gtm_server_domain: 'http://example.com', request_path:\
    \ 'foo/', expectedServerUrl: 'http://example.com/foo' },\n  { gtm_server_domain:\
    \ 'http://example.com/', request_path: 'foo/', expectedServerUrl: 'http://example.com/foo'\
    \ },\n].forEach((testCase, testNumber) => {\n  mockData.gtm_server_domain = testCase.gtm_server_domain;\n\
    \  mockData.request_path = testCase.request_path;\n  \n  mock('sendPixel', function(url,\
    \ onSuccess, onFailure) {\n    // logToConsole('#' + testNumber + ' - sendPixel\
    \ called with URL:', url);\n    assertThat(url).contains(testCase.expectedServerUrl);\n\
    \  });\n\n  runCode(mockData);\n});"
- name: GTM Server Side URL and Request Path for POST requests are normalized
  code: "mockData.request_type = 'post';\nmockData.event_type = 'standard';\nmockData.event_name_standard\
    \ = 'cc';\n\nmock('injectScript', function(url, onSuccess, onFailure, cacheToken)\
    \ {\n  onSuccess();\n});\n\nconst expectedRequestPathParams = '?v=' + mockData.protocol_version;\n\
    \n[\n  { gtm_server_domain: 'example.com', request_path: '/foo', expectedGtmServerDomain:\
    \ 'https://example.com', expectedRequestPath: '/foo' + expectedRequestPathParams\
    \ },\n  { gtm_server_domain: 'example.com/', request_path: '/foo', expectedGtmServerDomain:\
    \ 'https://example.com', expectedRequestPath: '/foo' + expectedRequestPathParams\
    \ },\n  { gtm_server_domain: 'https://example.com', request_path: '/foo', expectedGtmServerDomain:\
    \ 'https://example.com', expectedRequestPath: '/foo' + expectedRequestPathParams\
    \ },\n  { gtm_server_domain: 'https://example.com/', request_path: '/foo', expectedGtmServerDomain:\
    \ 'https://example.com', expectedRequestPath: '/foo' + expectedRequestPathParams\
    \ },\n  { gtm_server_domain: 'example.com', request_path: 'foo/', expectedGtmServerDomain:\
    \ 'https://example.com', expectedRequestPath: '/foo/' + expectedRequestPathParams\
    \ },\n  { gtm_server_domain: 'example.com/', request_path: 'foo/', expectedGtmServerDomain:\
    \ 'https://example.com', expectedRequestPath: '/foo/' + expectedRequestPathParams\
    \ },\n  { gtm_server_domain: 'https://example.com', request_path: 'foo/', expectedGtmServerDomain:\
    \ 'https://example.com', expectedRequestPath: '/foo/' + expectedRequestPathParams\
    \ },\n  { gtm_server_domain: 'https://example.com/', request_path: 'foo/', expectedGtmServerDomain:\
    \ 'https://example.com', expectedRequestPath: '/foo/' + expectedRequestPathParams\
    \ },\n  { gtm_server_domain: 'http://example.com', request_path: '/foo', expectedGtmServerDomain:\
    \ 'http://example.com', expectedRequestPath: '/foo' + expectedRequestPathParams\
    \ },\n  { gtm_server_domain: 'http://example.com/', request_path: '/foo', expectedGtmServerDomain:\
    \ 'http://example.com', expectedRequestPath: '/foo' + expectedRequestPathParams\
    \ },\n  { gtm_server_domain: 'http://example.com', request_path: 'foo/', expectedGtmServerDomain:\
    \ 'http://example.com', expectedRequestPath: '/foo/' + expectedRequestPathParams\
    \ },\n  { gtm_server_domain: 'http://example.com/', request_path: 'foo/', expectedGtmServerDomain:\
    \ 'http://example.com', expectedRequestPath: '/foo/' + expectedRequestPathParams\
    \ },\n].forEach((testCase, testNumber) => {\n  mockData.gtm_server_domain = testCase.gtm_server_domain;\n\
    \  mockData.request_path = testCase.request_path;\n  \n  mock('callInWindow',\
    \ function(functionName, eventData, gtmServerDomain, requestPath, dataLayerEventName,\
    \ dataLayerVariableName, waitForCookies, useFetchInsteadOfXHR) {\n    /*\n   \
    \ logToConsole('#' + testNumber + ' - callInWindow called with:', {\n      functionName:\
    \ functionName,\n      gtmServerDomain: gtmServerDomain,\n      requestPath: requestPath,\n\
    \    });\n    */\n    \n    assertThat(gtmServerDomain).isEqualTo(testCase.expectedGtmServerDomain);\n\
    \    const requestPathStartsWith = requestPath.indexOf(testCase.expectedRequestPath)\
    \ === 0;\n    assertThat(requestPathStartsWith).isTrue();\n  });\n\n  runCode(mockData);\n\
    });"
setup: |-
  const mockData = {
    protocol_version: '2'
  };


___NOTES___

Created on 21/03/2021, 11:26:46


