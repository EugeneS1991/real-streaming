# Real Streaming

## Overview

**Real Streaming** is a high-performance FastAPI-based real-time event streaming service designed to collect, enrich, and stream web analytics events directly to Google BigQuery. The service acts as a server-side event collection endpoint that can be integrated with web applications via JavaScript, similar to Google Analytics 4 (GA4) Measurement Protocol.

### What This Service Does

This service provides:

1. **Real-time Event Collection**: Accepts analytics events from web browsers via HTTP POST requests
2. **Server-side Enrichment**: Automatically enriches events with:
   - Device information (parsed from User-Agent)
   - Geographic location (from headers or IP)
   - Traffic source attribution (UTM parameters, referrer analysis)
3. **High-Performance Streaming**: Streams data to BigQuery using two strategies:
   - **Direct Streaming**: Uses BigQuery Storage Write API for maximum throughput
   - **Pub/Sub**: Publishes events to Google Cloud Pub/Sub for asynchronous processing
4. **Production-Ready Features**:
   - Automatic table creation with partitioning and clustering
   - Request batching and buffering for optimal performance
   - CORS support for cross-origin requests
   - Brotli compression for efficient data transfer
   - Comprehensive logging (local and Google Cloud Logging)

### Key Capabilities

- ✅ **GA4-Compatible Schema**: Events follow Google Analytics 4 BigQuery export schema
- ✅ **Device Detection**: Accurate device, browser, and OS detection using Matomo Device Detector
- ✅ **Traffic Source Attribution**: Automatic parsing of UTM parameters and referrer analysis
- ✅ **Cookie-based User Tracking**: Cross-subdomain cookie support (like Google Analytics)
- ✅ **Protobuf Serialization**: Efficient binary serialization for BigQuery Storage Write API
- ✅ **Auto-scaling**: Designed for Google Cloud Run with horizontal scaling
- ✅ **Error Handling**: Graceful error handling with retry logic and dead-letter queue support

---

## Architecture

### High-Level Flow

```
Web Browser → FastAPI Endpoint → Request Enrichment → Streaming Service → BigQuery/PubSub
                ↓
            Cookie Management
            Device Parsing
            Geo Detection
            Traffic Source Analysis
```

### Components

1. **API Layer** (`src/api/api_v1/streaming/`):
   - `router.py`: Main endpoint handler
   - `schemas.py`: Pydantic models for request/response validation
   - `dependencies/`: Request enrichment logic
   - `cookies.py`: Cookie management

2. **Storage Layer** (`src/storage/bigquery/`):
   - `client.py`: Streaming service factory
   - `writers/direct.py`: BigQuery Storage Write API implementation
   - `writers/pubsub.py`: Google Pub/Sub publisher
   - `table.py`: Table creation and management
   - `schema.py`: BigQuery table schema definition

3. **Core Layer** (`src/core/`):
   - `config.py`: Application configuration (Pydantic Settings)
   - `constants.py`: Application constants
   - `utils.py`: Utility functions

---

## Installation

### Prerequisites

- Python 3.10+ (tested with Python 3.14)
- Google Cloud Project with BigQuery API enabled
- Google Cloud Service Account with appropriate permissions (see [Permissions](#permissions))
- (Optional) Google Cloud Pub/Sub topic and subscription (if using Pub/Sub strategy)

### Local Development Setup

1. **Clone the repository**:
```bash
git clone <repository-url>
cd epmgoogrsd-stream-events
```

2. **Create a virtual environment**:
```bash
python -m venv venv
# On Windows
venv\Scripts\activate
# On Linux/Mac
source venv/bin/activate
```

3. **Install dependencies**:
```bash
pip install --upgrade pip
pip install -r requirements.txt
```

4. **Set up Google Cloud credentials**:
   - Create a service account in Google Cloud Console
   - Download the JSON key file
   - Set the environment variable:
```bash
# On Windows (PowerShell)
$env:GOOGLE_APPLICATION_CREDENTIALS="path/to/service-account-key.json"

# On Linux/Mac
export GOOGLE_APPLICATION_CREDENTIALS="path/to/service-account-key.json"
```

5. **Configure environment variables** (see [Configuration](#configuration) section)

6. **Run the application**:
```bash
uvicorn src.main:main_app --host 0.0.0.0 --port 8000 --reload
```

The API will be available at `http://localhost:8000`

### Docker Setup

1. **Build the Docker image**:
```bash
docker build -t epmgoogrsd-stream-events .
```

2. **Run the container**:
```bash
docker run -p 8080:8080 \
  -e GOOGLE_APPLICATION_CREDENTIALS=/path/to/key.json \
  -v /path/to/key.json:/path/to/key.json:ro \
  -v $(pwd)/src/.env:/app/src/.env:ro \
  epmgoogrsd-stream-events
```

> **Screenshot Placeholder 1**: Docker build output showing successful image creation
> *Description: Screenshot showing the output of `docker build` command with "Successfully built" message*

---

## Configuration

### Environment Variables

Create a `.env` file in the `src/` directory. The application uses nested configuration with the prefix `APP_CONFIG__`.

#### Basic Configuration

```bash
# Application Environment (QA for local development, PROD for production)
APP_CONFIG__ENVIRONMENT=QA

# Server Configuration
APP_CONFIG__RUN__HOST=0.0.0.0
APP_CONFIG__RUN__PORT=8000

# API Prefixes
APP_CONFIG__API__PREFIX=/api
APP_CONFIG__API__V1__PREFIX=/v1
APP_CONFIG__API__V1__STREAMING=/streaming
APP_CONFIG__API__V1__FETCH=/fetch
```

#### BigQuery Configuration

```bash
# Google Cloud Project ID
APP_CONFIG__WRITERS__PROJECT_ID=your-gcp-project-id

# Streaming Strategy: "direct" or "pubsub"
APP_CONFIG__WRITERS__STRATEGY=direct

# BigQuery Table Configuration
APP_CONFIG__WRITERS__BQ__DATASET_ID=analytics
APP_CONFIG__WRITERS__BQ__TABLE_ID=events_stream
APP_CONFIG__WRITERS__BQ__FLUSH_INTERVAL=0.5
APP_CONFIG__WRITERS__BQ__MAX_BATCH_SIZE=500
APP_CONFIG__WRITERS__BQ__MAX_QUEUE_SIZE=100000
```

**Configuration Parameters Explained**:
- `FLUSH_INTERVAL`: Time in seconds to wait before flushing a batch (even if not full)
- `MAX_BATCH_SIZE`: Maximum number of rows to include in a single batch
- `MAX_QUEUE_SIZE`: Maximum number of rows that can be queued before backpressure

#### Pub/Sub Configuration (if using Pub/Sub strategy)

```bash
# Pub/Sub Topic and Subscription
APP_CONFIG__WRITERS__PUBSUB__TOPIC_ID=streaming-events
APP_CONFIG__WRITERS__PUBSUB__SUBSCRIPTION_ID=streaming-events-sub
APP_CONFIG__WRITERS__PUBSUB__MAX_BYTES=1048576
APP_CONFIG__WRITERS__PUBSUB__PUBLISH_TIMEOUT=10.0
APP_CONFIG__WRITERS__PUBSUB__MAX_BATCH_SIZE=500
APP_CONFIG__WRITERS__PUBSUB__FLUSH_INTERVAL=0.5
```

#### CORS Configuration

```bash
# Allowed Origins (comma-separated list)
APP_CONFIG__CORS__ALLOWED_ORIGINS=["https://example.com","https://www.example.com"]
APP_CONFIG__CORS__ALLOW_CREDENTIALS=true
APP_CONFIG__CORS__ALLOW_METHODS=["GET","POST","OPTIONS"]
APP_CONFIG__CORS__ALLOW_HEADERS=["Content-Type","Set-Cookie","Access-Control-Allow-Headers","Access-Control-Allow-Origin","Authorization"]
```

#### Cookie Configuration

```bash
# Cookie Settings
APP_CONFIG__COOKIE__MAX_AGE=63072000
APP_CONFIG__COOKIE__SECURE=true
APP_CONFIG__COOKIE__HTTPONLY=true
APP_CONFIG__COOKIE__SAMESITE=none
```

**Cookie Parameters Explained**:
- `MAX_AGE`: Cookie expiration time in seconds (default: 2 years)
- `SECURE`: Only send cookie over HTTPS (set to `false` for local development)
- `HTTPONLY`: Prevent JavaScript access to cookie (security best practice)
- `SAMESITE`: Cookie same-site policy (`strict`, `lax`, or `none`)

### Complete .env Example

```bash
# Environment
APP_CONFIG__ENVIRONMENT=QA

# Server
APP_CONFIG__RUN__HOST=0.0.0.0
APP_CONFIG__RUN__PORT=8000

# API
APP_CONFIG__API__PREFIX=/api
APP_CONFIG__API__V1__PREFIX=/v1
APP_CONFIG__API__V1__STREAMING=/streaming
APP_CONFIG__API__V1__FETCH=/fetch

# BigQuery
APP_CONFIG__WRITERS__PROJECT_ID=my-gcp-project
APP_CONFIG__WRITERS__STRATEGY=direct
APP_CONFIG__WRITERS__BQ__DATASET_ID=analytics
APP_CONFIG__WRITERS__BQ__TABLE_ID=events_stream
APP_CONFIG__WRITERS__BQ__FLUSH_INTERVAL=0.5
APP_CONFIG__WRITERS__BQ__MAX_BATCH_SIZE=500
APP_CONFIG__WRITERS__BQ__MAX_QUEUE_SIZE=100000

# Pub/Sub (required even if using direct strategy)
APP_CONFIG__WRITERS__PUBSUB__TOPIC_ID=streaming-events
APP_CONFIG__WRITERS__PUBSUB__SUBSCRIPTION_ID=streaming-events-sub
APP_CONFIG__WRITERS__PUBSUB__MAX_BYTES=1048576
APP_CONFIG__WRITERS__PUBSUB__PUBLISH_TIMEOUT=10.0
APP_CONFIG__WRITERS__PUBSUB__MAX_BATCH_SIZE=500
APP_CONFIG__WRITERS__PUBSUB__FLUSH_INTERVAL=0.5

# CORS
APP_CONFIG__CORS__ALLOWED_ORIGINS=["http://localhost:3000","https://example.com"]
APP_CONFIG__CORS__ALLOW_CREDENTIALS=true

# Cookies
APP_CONFIG__COOKIE__MAX_AGE=63072000
APP_CONFIG__COOKIE__SECURE=false
APP_CONFIG__COOKIE__HTTPONLY=true
APP_CONFIG__COOKIE__SAMESITE=lax
```

> **Screenshot Placeholder 2**: Google Cloud Console showing service account with required permissions
> *Description: Screenshot of IAM & Admin > Service Accounts page showing a service account with BigQuery Data Editor, BigQuery Job User, and Pub/Sub Publisher roles*

---

## Google Cloud Pub/Sub Setup

If you're using the **Pub/Sub strategy** (`APP_CONFIG__WRITERS__STRATEGY=pubsub`), you need to set up Google Cloud Pub/Sub infrastructure.

### Step 1: Create a Pub/Sub Topic

1. Go to [Google Cloud Console](https://console.cloud.google.com) → Pub/Sub → Topics
2. Click **"Create Topic"**
3. Enter the topic ID (must match `APP_CONFIG__WRITERS__PUBSUB__TOPIC_ID`)
4. Configure topic settings:
   - **Message retention**: 7 days (default)
   - **Enable message ordering**: Optional (not required for this use case)
5. Click **"Create"**

> **Screenshot Placeholder 3**: Pub/Sub topic creation form in Google Cloud Console
> *Description: Screenshot showing the "Create Topic" form with topic ID field filled in and settings configured*

### Step 2: Create a Pub/Sub Subscription (Optional)

If you plan to consume messages from Pub/Sub (e.g., for a separate BigQuery loader service):

1. Navigate to your topic
2. Click **"Create Subscription"**
3. Enter subscription ID (must match `APP_CONFIG__WRITERS__PUBSUB__SUBSCRIPTION_ID`)
4. Configure subscription settings:
   - **Delivery type**: Pull or Push
   - **Acknowledgment deadline**: 60 seconds (default)
   - **Message retention**: 7 days
   - **Expiration**: Never
5. Click **"Create"**

> **Screenshot Placeholder 4**: Pub/Sub subscription creation form
> *Description: Screenshot showing subscription creation form with delivery type and retention settings*

### Step 3: Set Up BigQuery Subscription (Recommended)

For automatic loading from Pub/Sub to BigQuery:

1. Go to BigQuery Console → Your Dataset
2. Click **"Create Table"**
3. Select **"Google Cloud Pub/Sub"** as the source
4. Configure:
   - **Project**: Your GCP project
   - **Topic**: Select the topic created in Step 1
   - **Table name**: Same as `APP_CONFIG__WRITERS__BQ__TABLE_ID`
   - **Schema**: Use the schema from `src/storage/bigquery/schema.py` or enable auto-detection
5. Click **"Create Table"**

> **Screenshot Placeholder 5**: BigQuery table creation form with Pub/Sub as source
> *Description: Screenshot showing BigQuery "Create Table" wizard with Pub/Sub selected as data source and topic configured*

### Step 4: Grant Permissions

Ensure your service account has the following IAM roles:
- `roles/pubsub.publisher` (for publishing messages)
- `roles/bigquery.dataEditor` (if using BigQuery subscription)
- `roles/bigquery.jobUser` (if using BigQuery subscription)

> **Screenshot Placeholder 6**: IAM permissions page showing service account with Pub/Sub Publisher role
> *Description: Screenshot of IAM & Admin > IAM page showing the service account with "Pub/Sub Publisher" role assigned*

---

## Permissions

### Required Google Cloud IAM Roles

Your service account needs the following permissions:

#### For Direct Streaming Strategy:
- `roles/bigquery.dataEditor` - Write data to BigQuery tables
- `roles/bigquery.jobUser` - Create BigQuery jobs (for table creation)

#### For Pub/Sub Strategy:
- `roles/pubsub.publisher` - Publish messages to Pub/Sub topics

#### For Cloud Logging (Production):
- `roles/logging.logWriter` - Write logs to Cloud Logging

### Setting Up Permissions

1. Go to [IAM & Admin](https://console.cloud.google.com/iam-admin/iam) in Google Cloud Console
2. Find your service account
3. Click **"Edit"** (pencil icon)
4. Click **"Add Another Role"**
5. Select the required roles
6. Click **"Save"**

Alternatively, use gcloud CLI:
```bash
gcloud projects add-iam-policy-binding PROJECT_ID \
  --member="serviceAccount:SERVICE_ACCOUNT_EMAIL" \
  --role="roles/bigquery.dataEditor"

gcloud projects add-iam-policy-binding PROJECT_ID \
  --member="serviceAccount:SERVICE_ACCOUNT_EMAIL" \
  --role="roles/bigquery.jobUser"

gcloud projects add-iam-policy-binding PROJECT_ID \
  --member="serviceAccount:SERVICE_ACCOUNT_EMAIL" \
  --role="roles/pubsub.publisher"
```

---

## Running the Application

### Local Development

```bash
# Activate virtual environment
source venv/bin/activate  # Linux/Mac
# or
venv\Scripts\activate  # Windows

# Run with auto-reload
uvicorn src.main:main_app --host 0.0.0.0 --port 8000 --reload
```

The API will be available at:
- API Documentation: `http://localhost:8000/docs`
- Alternative docs: `http://localhost:8000/redoc`
- Streaming endpoint: `http://localhost:8000/api/v1/streaming/{stream_id}`

> **Screenshot Placeholder 7**: FastAPI Swagger UI showing the streaming endpoint
> *Description: Screenshot of the FastAPI automatic documentation at /docs showing the POST /api/v1/streaming/{stream_id} endpoint with request/response schemas*

### Production Deployment (Google Cloud Run)

The project includes a `cloudbuild.yaml` for automated deployment:

1. **Set Cloud Build substitution variables**:
   - `_AR_HOSTNAME`: Artifact Registry hostname (e.g., `us-central1-docker.pkg.dev`)
   - `_AR_REPO`: Artifact Registry repository name
   - `_SERVICE_NAME`: Cloud Run service name
   - `_DEPLOY_REGION`: Deployment region (e.g., `us-central1`)
   - `_PLATFORM`: Platform (`managed`)

2. **Trigger Cloud Build**:
```bash
gcloud builds submit --config=cloudbuild.yaml \
  --substitutions=_AR_HOSTNAME=us-central1-docker.pkg.dev,_AR_REPO=my-repo,_SERVICE_NAME=stream-events,_DEPLOY_REGION=us-central1,_PLATFORM=managed
```

3. **Set environment variables in Cloud Run**:
   - Go to Cloud Run → Your Service → Edit & Deploy New Revision
   - Add environment variables (same as `.env` but without `APP_CONFIG__` prefix)
   - Set `GOOGLE_APPLICATION_CREDENTIALS` to use the default service account

> **Screenshot Placeholder 8**: Cloud Run service configuration page showing environment variables
> *Description: Screenshot of Cloud Run service edit page with environment variables section showing all APP_CONFIG variables configured*

---

## API Usage

### Endpoint

```
POST /api/v1/streaming/{stream_id}
```

### Request Headers

- `Content-Type: application/json`
- `User-Agent`: (optional, used for device detection)
- `Accept-Language`: (optional, used for language detection)
- `X-Client-Geo-Country`: (optional, client country code)
- `X-Client-Geo-State`: (optional, client region/state)
- `X-Client-Geo-City`: (optional, client city)
- `Cookie: __uid__=<user_pseudo_id>`: (optional, for user tracking)

### Request Body

The request body follows the GA4 Measurement Protocol format:

```json
{
  "event_name": "page_view",
  "event_params": [
    {
      "key": "page_location",
      "value": {
        "string_value": "https://example.com/page"
      }
    },
    {
      "key": "page_title",
      "value": {
        "string_value": "Home Page"
      }
    }
  ],
  "user_id": "user123",
  "privacy_info": {
    "ad_storage": true,
    "analytics_storage": true
  },
  "user_properties": [
    {
      "key": "user_type",
      "value": {
        "string_value": "premium"
      }
    }
  ],
  "app_info": {
    "id": "web-app",
    "version": "1.0.0"
  },
  "ecommerce": {
    "transaction_id": "T12345",
    "value": 99.99,
    "currency": "USD"
  },
  "items": [
    {
      "item_id": "SKU123",
      "item_name": "Product Name",
      "price": 99.99,
      "quantity": 1
    }
  ]
}
```

### Response

```json
{
  "status": "ok"
}
```

### Example: JavaScript Integration

```javascript
// Send event to streaming endpoint
async function sendEvent(streamId, eventData) {
  const response = await fetch(`https://your-api.com/api/v1/streaming/${streamId}`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    credentials: 'include', // Important for cookies
    body: JSON.stringify(eventData)
  });
  
  return await response.json();
}

// Example: Track page view
sendEvent(1, {
  event_name: 'page_view',
  event_params: [
    {
      key: 'page_location',
      value: { string_value: window.location.href }
    },
    {
      key: 'page_title',
      value: { string_value: document.title }
    }
  ]
});
```

> **Screenshot Placeholder 9**: Browser Network tab showing successful POST request to streaming endpoint
> *Description: Screenshot of browser DevTools Network tab showing a POST request to /api/v1/streaming/1 with 200 OK response and Set-Cookie header for __uid__*

---

## BigQuery Table Schema

The service automatically creates a BigQuery table with the following structure:

- **Partitioning**: By `date` field (daily partitions)
- **Clustering**: By `user_pseudo_id` and `event_name`
- **Schema**: Compatible with GA4 BigQuery export schema

Key fields:
- `date`: Event date (DATE)
- `event_timestamp`: Event timestamp in microseconds (INTEGER)
- `event_name`: Event name (STRING)
- `event_params`: Array of event parameters (RECORD, REPEATED)
- `user_id`: User ID (STRING)
- `user_pseudo_id`: Anonymous user ID (STRING, used for clustering)
- `device`: Device information (RECORD)
- `geo`: Geographic information (RECORD)
- `collected_traffic_source`: Traffic source data (RECORD)
- `synced_at_utc_`: Server sync timestamp (TIMESTAMP)
- `synced_at_micros_`: Server sync timestamp in microseconds (INTEGER)

> **Screenshot Placeholder 10**: BigQuery table schema view showing all fields
> *Description: Screenshot of BigQuery table details page showing the schema with all fields, partitioning (by date), and clustering (by user_pseudo_id, event_name)*

---

## Monitoring and Logging

### Local Development (QA Environment)

When `APP_CONFIG__ENVIRONMENT=QA`, logs are written to stdout with detailed formatting:

```
DEBUG     2024-01-15 10:30:45.123 - main         - lifespan:34            - Application started successfully - [src/main.py]
INFO      2024-01-15 10:30:46.456 - router       - streaming:32           - Streaming batch of 10 rows - [src/api/api_v1/streaming/router.py]
```

### Production (Cloud Logging)

When `APP_CONFIG__ENVIRONMENT` is not `QA`, logs are automatically sent to Google Cloud Logging.

View logs:
```bash
gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=stream-events" --limit 50
```

> **Screenshot Placeholder 11**: Google Cloud Logging Explorer showing application logs
> *Description: Screenshot of Cloud Logging Explorer with filtered logs showing INFO and DEBUG messages from the streaming service*

---

## Troubleshooting

### Common Issues

#### 1. Table Creation Fails

**Error**: `google.api_core.exceptions.NotFound: Table not found`

**Solution**: 
- Ensure service account has `roles/bigquery.jobUser` permission
- Check that dataset exists in BigQuery
- Verify `APP_CONFIG__WRITERS__PROJECT_ID` is correct

#### 2. Pub/Sub Publish Fails

**Error**: `Permission denied on topic`

**Solution**:
- Ensure service account has `roles/pubsub.publisher` permission
- Verify topic exists and `APP_CONFIG__WRITERS__PUBSUB__TOPIC_ID` matches

#### 3. CORS Errors in Browser

**Error**: `Access to fetch at '...' from origin '...' has been blocked by CORS policy`

**Solution**:
- Add your domain to `APP_CONFIG__CORS__ALLOWED_ORIGINS`
- Ensure `APP_CONFIG__CORS__ALLOW_CREDENTIALS=true` if using cookies

#### 4. Cookies Not Set

**Issue**: `__uid__` cookie is not being set

**Solution**:
- Check `APP_CONFIG__COOKIE__SECURE` (should be `false` for HTTP localhost)
- Verify `credentials: 'include'` in fetch request
- Check domain extraction logic (localhost won't set domain)

---

## Project Structure

```
epmgoogrsd-stream-events/
├── src/
│   ├── api/
│   │   ├── api_v1/
│   │   │   ├── streaming/          # Main streaming endpoint
│   │   │   │   ├── router.py       # Endpoint handler
│   │   │   │   ├── schemas.py      # Pydantic models
│   │   │   │   ├── cookies.py      # Cookie management
│   │   │   │   └── dependencies/   # Request enrichment
│   │   │   └── fetch/              # Static file serving
│   │   └── __init__.py
│   ├── core/
│   │   ├── config.py               # Application configuration
│   │   ├── constants.py            # Constants (StreamingStrategy enum)
│   │   └── utils.py                # Utility functions
│   ├── storage/
│   │   └── bigquery/
│   │       ├── client.py           # Streaming service factory
│   │       ├── table.py            # Table management
│   │       ├── schema.py           # BigQuery schema definition
│   │       ├── writers/
│   │       │   ├── base.py         # StreamerProtocol interface
│   │       │   ├── direct.py       # BigQuery Direct writer
│   │       │   └── pubsub.py       # Pub/Sub writer
│   │       └── proto/              # Protobuf definitions
│   ├── log_config.py               # Logging configuration
│   └── main.py                     # FastAPI application entry point
├── static/
│   └── v6.js                       # JavaScript tracking script (optional)
├── Dockerfile                      # Docker image definition
├── cloudbuild.yaml                 # Google Cloud Build configuration
├── requirements.txt               # Python dependencies
└── README.md                       # This file
```

---

## Development

### Running Tests

```bash
# Install test dependencies
pip install pytest pytest-asyncio httpx

# Run tests
pytest
```

### Code Style

The project follows PEP 8 style guidelines. Consider using:
- `ruff` for linting
- `black` for code formatting
- `mypy` for type checking

---

## License

[Add your license information here]

---

## Support

For issues, questions, or contributions, please [create an issue](https://github.com/your-repo/issues) or contact the development team.
