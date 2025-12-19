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

## Quick Start

Choose your deployment option:

- 🚀 **[Run Locally](#local-development)** - Quick setup for local development and testing
- ☁️ **[Deploy to Cloud Run](#production-deployment-google-cloud-run)** - Production deployment on Google Cloud Run

> **Recommended**: Start with local development to test the application, then proceed to cloud deployment.

---

## Required Google Cloud Services

For production deployment, you need to enable and configure the following Google Cloud services:

### Required Services

- **VPC Network** - For reserving static IP addresses
  - Used for: Load Balancer frontend IP address
  - Service: [VPC Network](https://console.cloud.google.com/networking/vpc)

- **Cloud Load Balancer** - For routing traffic and collecting client IP/geolocation
  - Used for: HTTP(S) load balancing, adding client IP headers (`X-Forwarded-For`, `X-Client-Geo-*`)
  - Service: [Load Balancing](https://console.cloud.google.com/net-services/loadbalancing)
  - **Note**: Required if you want to collect IP addresses and geolocation data

- **Cloud Artifact Registry** - For storing Docker container images
  - Used for: Storing Docker images built by Cloud Build
  - Service: [Artifact Registry](https://console.cloud.google.com/artifacts)

- **Cloud Build** - For building and deploying the application
  - Used for: Building Docker images, pushing to Artifact Registry, deploying to Cloud Run
  - Service: [Cloud Build](https://console.cloud.google.com/cloud-build)

- **Cloud Run** - For running the application
  - Used for: Hosting the FastAPI application
  - Service: [Cloud Run](https://console.cloud.google.com/run)

- **BigQuery** - For storing analytics events
  - Used for: Storing streamed events data
  - Service: [BigQuery](https://console.cloud.google.com/bigquery)

### Optional Services

- **Cloud Pub/Sub** - For asynchronous event processing (if using Pub/Sub strategy)
  - Used for: Publishing events to Pub/Sub topics, then writing to BigQuery via subscription
  - Service: [Pub/Sub](https://console.cloud.google.com/cloudpubsub)
  - **Note**: Only required if `APP_CONFIG__WRITERS__STRATEGY=pubsub`


## Architecture

### High-Level Flow

```
                                        ┌───────────────────┐
                                        │     Web Browser   │
                                        └────────┬──────────┘
                                                 │
                                                 ▼
                                        ┌───────────────────┐
                                        │   Load Balancer   │
                                        │  (adds headers)   │
                                        └────────┬──────────┘
                                                 │
                                                 ▼
                                        ┌───────────────────┐
                                        │  FastAPI Endpoint │
                                        └────────┬──────────┘
                                                 │
                                 ┌───────────────┼────────────────┐
                                 │               │                │
                                 ▼               ▼                ▼
                        ┌────────────────┐ ┌────────────────┐ ┌────────────────┐
                        │   Cookie Mgmt  │ │ Device Parsing │ │  Geo Detection │
                        └────────────────┘ └────────────────┘ └────────────────┘
                                                 │
                                                 ▼
                                        ┌───────────────────┐
                                        │ Request Enrichment│
                                        └────────┬──────────┘
                                                 │
                                 ┌───────────────┴───────────────┐
                                 │                               │
                                 ▼                               ▼
                        ┌───────────────────┐           ┌───────────────────┐
                        │     (Pub/Sub)     │           │ Direct to BigQuery│    
                        └────────┬──────────┘           └────────┬──────────┘
                                 │                               │
                                 └───────────────┬───────────────┘
                                                 ▼
                                        ┌───────────────────┐
                                        │     BigQuery      │
                                        └───────────────────┘
 
```

## Installation

### Prerequisites

- Python 3.10+ (tested with Python 3.14)
- Google Cloud Project with BigQuery API enabled
- Google Cloud CLI installed and configured
- Google Cloud Service Account with appropriate permissions (see [Permissions](#permissions))

### Local Development Setup

Follow these steps to set up and run the application locally:

#### Step 1: Clone Repository and Install Dependencies

1. **Clone the repository**:
```bash
git clone <repository-url>
cd real-streaming
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

#### Step 2: Configure Environment Variables

1. **Copy the template file**:
```bash
cp .env.template src/.env
```

2. **Edit `src/.env`** and set the following required variables:

```bash
# Required: Google Cloud Project ID
APP_CONFIG__WRITERS__PROJECT_ID=your_project_id

# Required: BigQuery Dataset ID
APP_CONFIG__WRITERS__BQ__DATASET_ID=your_dataset_id

# Required: BigQuery Table ID
APP_CONFIG__WRITERS__BQ__TABLE_ID=your_table_id

# Required: Streaming strategy (use "direct" for local development)
APP_CONFIG__WRITERS__STRATEGY=direct

# Required: CORS allowed origins (for local development)
APP_CONFIG__CORS__ALLOWED_ORIGINS=["https://127.0.0.1:8080","http://127.0.0.1:8080","http://localhost:8080"]
```

> **Note**: Replace `your_project_id`, `your_dataset_id`, and `your_table_id` with your actual Google Cloud project, dataset, and table names.

#### Step 3: Set Up Google Cloud Application Default Credentials

The application uses [Application Default Credentials (ADC)](https://cloud.google.com/docs/authentication/application-default-credentials) for authentication with Google Cloud services.

For local development, authenticate using gcloud CLI:
```bash
gcloud auth application-default login
```

This will automatically configure credentials that will be used by the application. No need to set `GOOGLE_APPLICATION_CREDENTIALS` environment variable.

### Cloud BigQuery Setup (Direct Strategy)

> **Note**: For local development, we use the **Direct Strategy** (`APP_CONFIG__WRITERS__STRATEGY=direct`), which streams events directly to BigQuery using the BigQuery Storage Write API. This is the simplest setup for local testing.

#### Step 4: Create BigQuery Dataset

Before running the application, you need to create a BigQuery dataset:

1. Go to [Google Cloud Console](https://console.cloud.google.com) → BigQuery → SQL Workspace
2. Click on your project name in the left sidebar
3. Click **"Create Dataset"**
4. Enter the dataset ID (must match `APP_CONFIG__WRITERS__BQ__DATASET_ID` from Step 2)
5. Configure dataset settings:
   - **Data location**: Select your preferred region (e.g., `us-central1`)
   - **Default table expiration**: Optional (leave empty for no expiration)
   - **Encryption**: Use Google-managed encryption key (default)
6. Click **"Create Dataset"**

![BigQuery Dataset Creation](docs/images/bigquery_dataset_creation.png)

> **Note**: The table will be automatically created by the application on first use. No manual table creation is required.

#### Step 5: Run the Application Locally

Start the application:
```bash
uvicorn src.main:main_app --host 0.0.0.0 --port 8080 --reload
```

The API will be available at:
- API Documentation: `http://localhost:8080/docs`
- Alternative docs: `http://localhost:8080/redoc`
- Streaming endpoint: `http://localhost:8080/api/v1/streaming/{stream_id}`

After starting the application, check the console output. You should see a message indicating that the table was created:

![Table Created in Console](docs/images/table_created.png)

**Verify table creation in BigQuery:**

1. Go to [Google Cloud Console](https://console.cloud.google.com) → BigQuery → SQL Workspace
2. Navigate to your dataset (created in Step 4)
3. Verify that the table (specified in `APP_CONFIG__WRITERS__BQ__TABLE_ID`) was automatically created
4. Click on the table name to view its details

#### Step 6: Send a Test Request via API Documentation

1. Open `http://localhost:8080/docs` in your browser
2. Find the `POST /api/v1/streaming/{stream_id}` endpoint
3. Click **"Try it out"**
4. Set `stream_id` to `1` (or any number)
5. Fill in the request body using the schema shown in Swagger UI (the request body structure is displayed in the documentation)
6. Click **"Execute"**

![Test Request in Swagger UI](docs/images/test_request.png)

#### Step 7: Verify Data in BigQuery

1. Go to [Google Cloud Console](https://console.cloud.google.com) → BigQuery → SQL Workspace
2. Navigate to your dataset and table
3. Click on the table name
4. Click **"Preview"** tab to view the data
5. Or run a SQL query:
```sql
SELECT * FROM `your_project_id.your_dataset_id.your_table_id`
ORDER BY event_timestamp DESC
LIMIT 10;
```

You should see your test event data in the table:

![Data in BigQuery Table](docs/images/data_in_bq.png)

---

### Next Steps: Google Cloud Pub/Sub Setup

If you want to use the **Pub/Sub strategy** instead of Direct streaming, follow the setup instructions below. The Pub/Sub strategy allows for asynchronous event processing and better scalability.

---

## Google Cloud Pub/Sub Setup

If you're using the **Pub/Sub strategy** (`APP_CONFIG__WRITERS__STRATEGY=pubsub`), you need to set up Google Cloud Pub/Sub infrastructure.

> **⚠️ Important**: Before setting up Pub/Sub strategy, you **must first** run the application with **Direct strategy** (`APP_CONFIG__WRITERS__STRATEGY=direct`) to create the BigQuery table. The Pub/Sub subscription requires an existing table to write data to BigQuery.

### Step 1: Configure Environment Variables

Update your `src/.env` file to use Pub/Sub strategy:

```bash
# Change streaming strategy to pubsub
APP_CONFIG__WRITERS__STRATEGY=pubsub

# Configure Pub/Sub topic and subscription IDs
APP_CONFIG__WRITERS__PUBSUB__TOPIC_ID=your_topic_id
APP_CONFIG__WRITERS__PUBSUB__SUBSCRIPTION_ID=your_subscription_id
```

> **Note**: Replace `your_topic_id` and `your_subscription_id` with your actual Pub/Sub topic and subscription names. These will be created in the following steps.

### Step 2: Create a Pub/Sub Topic

1. Go to [Google Cloud Console](https://console.cloud.google.com) → Pub/Sub → Topics
2. Click **"Create Topic"**
3. Enter the topic ID (must match `APP_CONFIG__WRITERS__PUBSUB__TOPIC_ID` from Step 1)
4. Click **"Create"**

![Create Pub/Sub Topic](docs/images/create_topic.png)

> *Screenshot showing the "Create Topic" form with topic ID field filled in and settings configured*

### Step 3: Create a BigQuery Subscription

For automatic loading from Pub/Sub to BigQuery:

1. Navigate to your Pub/Sub topic (created in Step 2)
2. Click **"Create Subscription"**
3. Enter subscription ID (must match `APP_CONFIG__WRITERS__PUBSUB__SUBSCRIPTION_ID` from Step 1)
4. Configure subscription settings:
   - **Delivery type**: Write to BigQuery
   - **Schema Configuration**: Use table schema
   - **Write metadata**: True (check this option)
5. Select the existing BigQuery table (created when running with Direct strategy)
6. Click **"Create"**

![Create BigQuery Subscription](docs/images/create_subscription.png)

> *Screenshot showing subscription creation form with "Write to BigQuery" delivery type, "Use table schema" configuration, and "Write metadata" enabled*

### Step 4: Test the Pub/Sub Setup

1. **Restart your application** with the updated configuration (Pub/Sub strategy):
```bash
uvicorn src.main:main_app --host 0.0.0.0 --port 8080 --reload
```

2. **Send a test request** via API Documentation:
   - Open `http://localhost:8080/docs` in your browser
   - Find the `POST /api/v1/streaming/{stream_id}` endpoint
   - Click **"Try it out"**
   - Set `stream_id` to `1` (or any number)
   - Fill in the request body using the schema shown in Swagger UI
   - Click **"Execute"**

![Test Request in Swagger UI](docs/images/test_request.png)

3. **Verify data in BigQuery**:
   - Go to [Google Cloud Console](https://console.cloud.google.com) → BigQuery → SQL Workspace
   - Navigate to your dataset and table
   - Click on the table name
   - Click **"Preview"** tab to view the data
   - Or run a SQL query:
```sql
SELECT * FROM `your_project_id.your_dataset_id.your_table_id`
ORDER BY event_timestamp DESC
LIMIT 10;
```

You should see your test event data in the table:

![Data in BigQuery Table](docs/images/data_in_bq.png)

> **Note**: With Pub/Sub strategy, data flows through Pub/Sub topic → Subscription → BigQuery table. There may be a slight delay before data appears in BigQuery.

---

## Deployment to Cloud Run

This section covers the steps required to deploy the application to Google Cloud Run and set up the necessary infrastructure for production use.

> **⚠️ Important**: The following configuration uses **minimal settings** suitable for initial deployment and testing. For production workloads with higher traffic, you should adjust the following parameters:
> - Autoscaling limits (min/max instances)
> - CPU and memory allocation
> - Request timeout settings
> - Concurrency settings
> 
> Review and adjust these settings based on your expected load after initial deployment.

### Step 1: Connect GitHub to Cloud Build

1. Go to [Google Cloud Console](https://console.cloud.google.com) → Cloud Run → Services
2. Click **"Create Service"**
3. Under **"Deployment"**, select **"Continuously deploy from a repository (source or function)"**
4. Select **"GitHub"** as the source
5. Under **"Build"**, select **"Cloud Build"**
6. Click **"Set up with Cloud Build"**
7. Configure the build:
   - **Source repository**: Connect your GitHub repository (if not already connected)
   - **Branch**: Set to `^main$` (or your main branch name)
   - **Build type**: Select **"Dockerfile"**
   - **Source location**: `/Dockerfile`
8. Click **"Save"**

![Connect GitHub to Cloud Build](docs/images/git_to_cloud_build.png)

> *Screenshot showing Cloud Build configuration with GitHub repository connection and Dockerfile build settings*

### Step 2: Configure Cloud Run Service

After connecting GitHub, configure your Cloud Run service settings:

#### Basic Configuration

1. **Service name**: Enter a name (e.g., `real-streaming`)
2. **Region**: Select your preferred region (e.g., `europe-west1`, `us-central1`)
3. **Allow unauthenticated invocations**: Enable **"Public access"** (check this option)

#### Container Settings

1. Click **"Container"** tab or section
2. Configure the following:

   **CPU allocation and pricing:**
   - **CPU**: Select based on your needs (start with minimum)
   - **Memory**: Select based on your needs (start with minimum)
   - **Billing**: Select **"Request-based"** (pay per request)

   **Autoscaling:**
   - **Min instances**: `0` (allows scaling to zero when no traffic)
   - **Max instances**: `2` (adjust based on expected load)

   **Ingress:**
   - **Allow traffic from external Application Load Balancers**: **Enable** (check this option)
   - This allows the Load Balancer (configured later) to route traffic to your Cloud Run service

#### Environment Variables

1. Click **"Variables & Secrets"** tab
2. Click **"Add Variable"** for each of the following:

```bash
APP_CONFIG__WRITERS__PROJECT_ID=your_project_id
APP_CONFIG__WRITERS__BQ__DATASET_ID=your_dataset_id
APP_CONFIG__WRITERS__BQ__TABLE_ID=your_table_id
APP_CONFIG__WRITERS__PUBSUB__TOPIC_ID=your_topic_id
APP_CONFIG__WRITERS__PUBSUB__SUBSCRIPTION_ID=your_subscription_id
APP_CONFIG__ENVIRONMENT=PROD
APP_CONFIG__CORS__ALLOWED_ORIGINS=["https://yourdomain.com"]
```

> **Note**: 
> - Replace all placeholder values (`your_project_id`, `your_dataset_id`, etc.) with your actual values
> - For `APP_CONFIG__CORS__ALLOWED_ORIGINS`, use the domain that will be connected to the Load Balancer
> - You can leave `APP_CONFIG__CORS__ALLOWED_ORIGINS` empty initially and set it after deploying and configuring the Load Balancer with your domain
> - Use the same values you configured in your local `.env` file

3. Click **"Create"** or **"Deploy"** to start the deployment

> **Note**: The first deployment may take several minutes as Cloud Build builds the Docker image and deploys it to Cloud Run.

### Step 3: Reserve a Static IP Address

> **Note**: This IP address will be used for the Load Balancer (configured in the next section). Reserve it now so it's ready when you set up the Load Balancer.

1. Go to [Google Cloud Console](https://console.cloud.google.com) → VPC network → IP addresses
2. Click **"Reserve External Static IP Address"** (or **"Reserve Internal Static IP Address"** if using internal load balancer)
3. Configure the IP address:
   - **Name**: Enter a name for the IP address (e.g., `real-streaming-lb-ip`)
   - **IP version**: IPv4
   - **Type**: 
     - **Global** - for HTTP(S) Load Balancer (recommended)
     - **Regional** - for Network Load Balancer
   - **Network tier**: Premium (recommended for better performance)
4. Click **"Reserve"**
5. **Note the IP address** - you'll need it for DNS configuration later

![Reserve Static IP Address](docs/images/reserv_ip.png)

> *Screenshot showing the IP address reservation form with configuration options*

### Google Cloud Load Balancer Setup

> **⚠️ Required for IP and Geolocation Collection**: If you want to collect client IP addresses and geolocation data, you **must** set up a Google Cloud Load Balancer. The Load Balancer adds specific headers (`X-Forwarded-For`, `X-Client-Geo-*`) that contain the client's IP address and geographic information, which Cloud Run cannot provide directly.

#### Step 1: Create HTTP(S) Load Balancer

1. Go to [Google Cloud Console](https://console.cloud.google.com) → Network Services → Load Balancing
2. Click **"Create Load Balancer"**
3. Under **"HTTP(S) Load Balancing"**, click **"Start Configuration"**
4. Select **"Internet facing"** (or **"Internal"** if using internal load balancer)
5. Select **"Global"** (recommended) or **"Regional"** based on your needs
6. Click **"Configure"**

#### Step 2: Configure Backend Service

1. Click **"Backend Configuration"**
2. Click **"Create or select backend services & backend buckets"**
3. Click **"Backend services"** → **"Create Backend Service"**
4. Configure backend service:
   - **Name**: Enter a name (e.g., `real-streaming-backend`)
   - **Backend type**: Select **"Serverless NEG"** (Network Endpoint Group)
   - **Serverless NEG**: Click **"Create Serverless NEG"**
     - **Name**: Enter a name (e.g., `real-streaming-neg`)
     - **Region**: Select the region where your Cloud Run service is deployed
     - **Cloud Run service**: Select your Cloud Run service name
     - Click **"Create"**
   - **Protocol**: HTTP
   - **Port**: 80 (or 443 for HTTPS)
   - **Timeout**: 30 seconds (default)
5. Click **"Create"** to create the backend service
6. Click **"Done"** to return to load balancer configuration

#### Step 3: Configure Frontend

1. Click **"Frontend Configuration"**
2. Configure frontend:
   - **Protocol**: HTTPS (recommended) or HTTP
   - **IP address**: Select the static IP address reserved in Step 1
   - **Port**: 443 (for HTTPS) or 80 (for HTTP)
   - **Certificate**: 
     - For HTTPS: Create or select an SSL certificate
     - For HTTP: No certificate needed
3. Click **"Done"**

#### Step 4: Review and Create

1. Review all configurations
2. Enter a **name** for the load balancer (e.g., `real-streaming-lb`)
3. Click **"Create"**

> **Note**: It may take a few minutes for the load balancer to be provisioned and become active.

#### Step 5: Configure DNS (Optional but Recommended)

1. Go to your DNS provider (e.g., Google Cloud DNS, Cloudflare, etc.)
2. Create an **A record** pointing your domain to the static IP address reserved in Step 1
3. For HTTPS, ensure your SSL certificate covers your domain name

### Important Headers

Once the Load Balancer is configured, it will automatically add the following headers to requests:

- `X-Forwarded-For`: Client's original IP address
- `X-Client-Geo-Country`: Client's country code (if available)
- `X-Client-Geo-Region`: Client's region/state (if available)
- `X-Client-Geo-City`: Client's city (if available)

These headers are automatically parsed by the application to enrich event data with geolocation information.

---

> **Note**: This project is designed to run on **Google Cloud Run**. For production deployment, see the [Production Deployment](#production-deployment-google-cloud-run) section.

---

## Configuration

### Environment Variables

The project includes a `.env.template` file with all configuration options. To configure the application:

1. **Copy the template file**:
```bash
cp .env.template src/.env
```

2. **Edit `src/.env`** and update the values according to your environment.


### Key Configuration Parameters

#### Required Settings

- `APP_CONFIG__ENVIRONMENT`: Application environment (`QA` for local development, `PROD` for production)
- `APP_CONFIG__WRITERS__PROJECT_ID`: Your Google Cloud Project ID
- `APP_CONFIG__WRITERS__STRATEGY`: Streaming strategy (`direct` for BigQuery Storage Write API, or `pubsub` for Pub/Sub)
- `APP_CONFIG__WRITERS__BQ__DATASET_ID`: BigQuery dataset name
- `APP_CONFIG__WRITERS__BQ__TABLE_ID`: BigQuery table name
- `APP_CONFIG__CORS__ALLOWED_ORIGINS`: List of allowed origins for CORS (JSON array format)

---

## Google Cloud BigQuery Setup (Direct Strategy)

> **Note**: This section is for reference. For local development setup, see the [Cloud BigQuery Setup (Direct Strategy)](#cloud-bigquery-setup-direct-strategy) section under Local Development Setup.

If you're using the **Direct streaming strategy** (`APP_CONFIG__WRITERS__STRATEGY=direct`), you need to set up Google Cloud BigQuery infrastructure.

### Step 1: Create a BigQuery Dataset

1. Go to [Google Cloud Console](https://console.cloud.google.com) → BigQuery → SQL Workspace
2. Click on your project name in the left sidebar
3. Click **"Create Dataset"**
4. Enter the dataset ID (must match `APP_CONFIG__WRITERS__BQ__DATASET_ID`)
5. Configure dataset settings:
   - **Data location**: Select your preferred region (e.g., `us-central1`)
   - **Default table expiration**: Optional (leave empty for no expiration)
   - **Encryption**: Use Google-managed encryption key (default)
6. Click **"Create Dataset"**

![BigQuery Dataset Creation](docs/images/bigquery_dataset_creation.png)

> *Screenshot showing the "Create Dataset" form with dataset ID and location configured*

> **Note**: The table will be automatically created by the application on first use. No manual table creation is required.

---

## Permissions

### Required Google Cloud IAM Roles

Your account needs the following permissions:

#### For Direct Streaming Strategy:
- `roles/bigquery.dataEditor` - Write data to BigQuery tables
- `roles/bigquery.jobUser` - Create BigQuery jobs (for table creation)

#### For Pub/Sub Strategy:
- `roles/pubsub.publisher` - Publish messages to Pub/Sub topics

#### For Cloud Logging (Production):
- `roles/logging.logWriter` - Write logs to Cloud Logging


## Running the Application

### Local Development

#### Prerequisites

Before running locally, make sure you have:

1. **Python 3.10+** installed
2. **Google Cloud credentials** configured (see [Installation](#installation) section)
3. **Environment variables** configured (see [Configuration](#configuration) section)

#### Quick Setup

1. **Install dependencies**:
```bash
pip install --upgrade pip
pip install -r requirements.txt
```

2. **Set up Application Default Credentials**:
```bash
gcloud auth application-default login
```

3. **Configure environment variables**:
```bash
# Copy the template file
cp .env.template src/.env

# Edit src/.env and update the values
```

4. **Run the application**:
```bash
uvicorn src.main:main_app --host 0.0.0.0 --port 8000 --reload
```

The API will be available at:
- API Documentation: `http://localhost:8000/docs`
- Alternative docs: `http://localhost:8000/redoc`
- Streaming endpoint: `http://localhost:8000/api/v1/streaming/{stream_id}`

> **Screenshot Placeholder 7**: FastAPI Swagger UI showing the streaming endpoint
> *Description: Screenshot of the FastAPI automatic documentation at /docs showing the POST /api/v1/streaming/{stream_id} endpoint with request/response schemas*

### Production Deployment (Google Cloud Run)

This project is designed to run on **Google Cloud Run**. The project includes a `cloudbuild.yaml` configuration file for automated deployment using Google Cloud Build.

#### Prerequisites

- Google Cloud Project with Cloud Run API enabled
- Artifact Registry repository for Docker images
- Cloud Build API enabled
- Service account with required permissions (see [Permissions](#permissions) section)

#### Deployment Steps

1. **Set Cloud Build substitution variables**:
   - `_AR_HOSTNAME`: Artifact Registry hostname (e.g., `us-central1-docker.pkg.dev`)
   - `_AR_REPO`: Artifact Registry repository name
   - `_SERVICE_NAME`: Cloud Run service name (e.g., `real-streaming`)
   - `_DEPLOY_REGION`: Deployment region (e.g., `us-central1`)
   - `_PLATFORM`: Platform (`managed`)

2. **Trigger Cloud Build**:
```bash
gcloud builds submit --config=cloudbuild.yaml \
  --substitutions=_AR_HOSTNAME=us-central1-docker.pkg.dev,_AR_REPO=my-repo,_SERVICE_NAME=real-streaming,_DEPLOY_REGION=us-central1,_PLATFORM=managed
```

   This will:
   - Build the Docker image
   - Push it to Artifact Registry
   - Deploy to Cloud Run

3. **Configure environment variables in Cloud Run**:
   - Go to Cloud Run → Your Service → Edit & Deploy New Revision
   - Add environment variables (same format as `.env` file, with `APP_CONFIG__` prefix)
   - The service will automatically use the default service account credentials (Application Default Credentials)

#### Environment Variables in Cloud Run

When deploying to Cloud Run, set environment variables in the Cloud Run service configuration. Use the same variable names as in your `.env` file (with `APP_CONFIG__` prefix). For example:

- `APP_CONFIG__ENVIRONMENT=PROD`
- `APP_CONFIG__WRITERS__PROJECT_ID=your-gcp-project-id`
- `APP_CONFIG__WRITERS__BQ__DATASET_ID=analytics`
- `APP_CONFIG__WRITERS__BQ__TABLE_ID=table_name`
- `APP_CONFIG__CORS__ALLOWED_ORIGINS=["https://yourdomain.com"]`

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
real-streaming/
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
