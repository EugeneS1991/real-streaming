___INFO___

{
  "type": "TAG",
  "id": "cvt_simple_streaming",
  "version": 1,
  "securityGroups": [],
  "displayName": "Simple Streaming Tag",
  "categories": [
    "ANALYTICS",
    "CONVERSIONS"
  ],
  "brand": {
    "id": "github.com_stape-io",
    "displayName": "stape-io"
  },
  "description": "Simple tag for sending streaming data to the server.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "server_url",
    "displayName": "Server URL",
    "simpleValueType": true,
    "help": "Full URL to send data to. Example: https://localhost:8080/api/v1/streaming/1",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      },
      {
        "type": "REGEX",
        "args": [
          "^(https://|http://).*"
        ],
        "errorMessage": "URL must start with https:// or http://"
      }
    ],
    "alwaysInSummary": true
  },
  {
    "type": "TEXT",
    "name": "event_name",
    "displayName": "Event Name",
    "simpleValueType": true,
    "defaultValue": "page_view",
    "help": "Name of the event to send",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "alwaysInSummary": true
  },
  {
    "type": "TEXT",
    "name": "data_tag_script_url",
    "displayName": "Data Tag Script URL",
    "simpleValueType": true,
    "help": "URL to load Data tag script from. Default: https://stapecdn.com/dtag/v8.js",
    "valueValidators": [
      {
        "type": "REGEX",
        "args": [
          "^(https://).*(\\.js)$"
        ]
      }
    ],
    "alwaysInSummary": false,
    "defaultValue": "https://stapecdn.com/dtag/v8.js"
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const injectScript = require('injectScript');
const callInWindow = require('callInWindow');
const makeString = require('makeString');
const encodeUriComponent = require('encodeUriComponent');
const makeNumber = require('makeNumber');

// Parse URL to extract domain and path
function parseUrl(fullUrl) {
  let url = fullUrl.trim();
  
  // Remove trailing slash if present
  if (url.charAt(url.length - 1) === '/') {
    url = url.slice(0, -1);
  }
  
  // Find protocol
  const protocolIndex = url.indexOf('://');
  if (protocolIndex === -1) {
    return null;
  }
  
  const protocol = url.substring(0, protocolIndex);
  const rest = url.substring(protocolIndex + 3);
  
  // Find path
  const pathIndex = rest.indexOf('/');
  if (pathIndex === -1) {
    return {
      domain: protocol + '://' + rest,
      path: '/'
    };
  }
  
  const domain = protocol + '://' + rest.substring(0, pathIndex);
  const path = rest.substring(pathIndex);
  
  return {
    domain: domain,
    path: path
  };
}

// Build payload according to Payload schema
function buildPayload() {
  const payload = {
    event_name: makeString(data.event_name),
    v: 2
  };
  
  return payload;
}

// Send POST request
function sendPostRequest() {
  const urlParts = parseUrl(data.server_url);
  
  if (!urlParts) {
    data.gtmOnFailure();
    return;
  }
  
  const payload = buildPayload();
  
  // Build request path with query string
  const requestPath = urlParts.path +
    '?v=' +
    payload.v +
    '&event=' +
    encodeUriComponent(payload.event_name);
  
  callInWindow(
    'dataTagSendData',
    payload,
    urlParts.domain,
    requestPath,
    null, // dataLayerEventName
    'dataLayer', // dataLayerVariableName
    false, // waitForCookies
    true // useFetchInsteadOfXHR
  );
  
  data.gtmOnSuccess();
}

// Load Data Tag script and send request
const dataTagScriptUrl = data.data_tag_script_url || 'https://stapecdn.com/dtag/v8.js';

injectScript(
  dataTagScriptUrl,
  sendPostRequest,
  data.gtmOnFailure,
  dataTagScriptUrl
);


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
                "string": "https://stapecdn.com/dtag/*"
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

scenarios: []


___NOTES___

Created for simple streaming data sending.

