___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "New Olex",
  "categories": [
    "ANALYTICS",
    "CONVERSIONS"
  ],
  "brand": {
    "id": "github.com_stape-io",
    "displayName": ""
  },
  "description": "Use this tag for sending data to the Server Container.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "stream_id",
    "displayName": "Streaming ID",
    "simpleValueType": true
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
    "displayName": "GTM Server Side URL",
    "simpleValueType": true,
    "help": "Domain to where the tag will send requests. For example https://gtm.example.com",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      },
      {
        "type": "REGEX",
        "args": [
          "^(https://).*"
        ],
        "errorMessage": "URL must start with https://"
      }
    ],
    "alwaysInSummary": true
  },
  {
    "type": "CHECKBOX",
    "name": "add_data_layer",
    "checkboxText": "Send all from DataLayer",
    "simpleValueType": true,
    "help": "Adds all Data Layer values to the request"
  },
  {
    "type": "CHECKBOX",
    "name": "add_common",
    "checkboxText": "Send common data",
    "simpleValueType": true,
    "help": "Adds to request page_location, page_path, page_hostname, page_referrer, page_title, page_encoding, screen_resolution, viewport_size",
    "defaultValue": true
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
            "value": "auto",
            "displayValue": "Auto"
          },
          {
            "value": "post",
            "displayValue": "POST"
          },
          {
            "value": "get",
            "displayValue": "GET"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "auto",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "help": "We highly recommend using \u003cb\u003eAuto\u003c/b\u003e. Change this only if you know what you do."
      },
      {
        "type": "TEXT",
        "name": "request_path",
        "displayName": "Path",
        "simpleValueType": true,
        "defaultValue": "/data",
        "help": "The path used for sending requests to the GTM Server Side container. If you use Data client on GTM Server Side Path should be \u003cb\u003e/data\u003c/b\u003e",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "protocol_version",
        "displayName": "Protocol version",
        "simpleValueType": true,
        "defaultValue": 2,
        "help": "Protocol version that used for sending a request to Data client on GTM Server Side.",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "data_tag_script",
        "displayName": "Data Tag Script URL",
        "simpleValueType": true,
        "help": "Url, where to load data tag script from, by default will be loaded from https://cdn.stape.io/dtag/v6.js",
        "valueValidators": [
          {
            "type": "REGEX",
            "args": [
              "^(https://).*(\\.js)$"
            ]
          }
        ],
        "alwaysInSummary": false,
        "defaultValue": "https://cdn.stape.io/dtag/v6.js"
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
        "help": "Use dataLayer by default. Modify only if you renamed dataLayer object name."
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
        "help": "Useful if you have server-side tags, that (partially) depend on the sendPixelFromBrowser() api for 3rd party cookies (e.g. Google Ads Conversion, Google Ads Remarketing)",
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
const log = require("logToConsole");
let pageLocation = getUrl();

//log(getCookieValues('uid'));
//log(getCookieValues('session_id'));

let requestType = determinateRequestType();

if (requestType === 'post') {
  const dataTagScriptUrl =
    data.data_tag_script || 'https://stream.anywhere.epam.com/v6.js';
  injectScript(
    dataTagScriptUrl,
    sendPostRequest,
    data.gtmOnFailure,
    dataTagScriptUrl
  );
} else {
  sendGetRequest();
}

function sendPostRequest() {
  let eventParams = {};

  eventParams = addCommonDataForPostRequest(data, eventParams);
  eventParams = addRequiredDataForPostRequest(data, eventParams);
  eventParams = addGaRequiredData(data, eventParams);

  const eventData = {
    stream_id: data.stream_id,
    event_name: getEventName(data),
    
    event_params: eventParams,
    user_properties: (data.user_data || []).reduce((acc, cur) => {
      acc[cur.name] = cur.value;
      return acc;
    } , {}),
  };

  callInWindow(
    'dataTagSendData',
    eventData,
    data.gtm_server_domain,
    data.request_path,
    data.dataLayerEventName,
    data.dataLayerVariableName,
    data.waitForCookies
  );

  data.gtmOnSuccess();
}

function sendGetRequest() {
  sendPixel(
    addDataForGetRequest(data, buildEndpoint()),
    data.gtmOnSuccess,
    data.gtmOnFailure
  );
}

function buildEndpoint() {
  return data.gtm_server_domain + data.request_path;
}

function addRequiredDataForPostRequest(data, eventData) {

  let customData = getCustomData(data, true);

  for (let key in customData) {
    eventData[customData[key].name] = customData[key].value;
  }

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
  }

  return eventData;
}

function addDataForGetRequest(data, url) {
  let eventData = {};
  url +=
    '?v=' +
    data.protocol_version +
    '&event_name=' +
    encodeUriComponent(getEventName(data));

  if (data.add_common) {
    eventData = addCommonData(data, eventData);
  }

  let customData = getCustomData(data, false);

  if (customData.length) {
    for (let customDataKey in customData) {
      eventData[customData[customDataKey].name] =
        customData[customDataKey].value;
    }
  }

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
  let customData = [];

  if (data.custom_data && data.custom_data.length) {
    customData = data.custom_data;
  }

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
  let dataToStoreCookie = getCookieValues('stape')[0];

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
    let dataToStoreLocalStorage = localStorage.getItem('stape');

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
      'stape',
      JSON.stringify(dataToStoreLocalStorageResult)
    );
  }

  if (getObjectLength(dataToStoreCookieResult) !== 0) {
    setCookie('stape', JSON.stringify(dataToStoreCookieResult), {
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

  let customDataLength = 0;
  let userDataLength = 0;

  if (data.custom_data && data.custom_data.length)
    customDataLength = makeNumber(JSON.stringify(data.custom_data).length);
  if (data.user_data && data.user_data.length)
    userDataLength = makeNumber(JSON.stringify(data.user_data).length);

  return customDataLength + userDataLength > 1500 ? 'post' : 'get';
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
                "string": "https://stream.anywhere.epam.com/*"
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
                    "string": "stape"
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
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "uid"
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
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "session_id"
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
                "string": "stape"
              },
              {
                "type": 1,
                "string": "uid"
              },
              {
                "type": 1,
                "string": "session_id"
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
                    "string": "stape"
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
                    "string": "uid"
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
                    "string": "session_id"
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
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "all"
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

scenarios: []


___NOTES___

Created on 21/03/2021, 11:26:46


