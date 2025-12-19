from google.cloud import bigquery
from google.api_core.exceptions import Conflict, NotFound

from src.core.config import settings
from src.storage.bigquery.schema import streaming_schema
from src.log_config import logger



def _table_exists(client: bigquery.Client) -> bool:
    """Internal check if the configured table exists in BigQuery."""
    table_path = settings.writers.bq.table_path(settings.writers.project_id)
    try:
        client.get_table(table_path)
        return True
    except NotFound:
        return False


def _create_table(client: bigquery.Client) -> str:   
    """
    Internal creation logic.
    Creates the configured table in BigQuery using schema from streaming_schema model.
    """
    table_path = settings.writers.bq.table_path(settings.writers.project_id)    
    logger.info(f"Creating table: {table_path}")

    table = bigquery.Table(table_path, schema=streaming_schema.schema)

    table.clustering_fields = streaming_schema.clustering_field
    table.time_partitioning = bigquery.TimePartitioning(
            type_=bigquery.TimePartitioningType.DAY,
            field=streaming_schema.partitioning_field,
            expiration_ms=None,
        )

    try:
        created_table = client.create_table(table)
        logger.info(
            f"Table created: {created_table.project}.{created_table.dataset_id}.{created_table.table_id}"
        )
        return "OK"
    except Conflict:
        logger.info(f"Table already exists: {table_path}")
        return "EXISTS"
    except Exception as e:
        logger.error(f"Error creating table: {e}")
        raise


def ensure_table() -> None:
    """
    Public API: Ensure the configured table exists.
    
    This function manages its own BigQuery Client lifecycle:
    1. Creates a client.
    2. Checks/Creates the table.
    3. Closes the client (ensure cleanup).
    """
    # Create a temporary client just for this operation
    # It will be closed in the finally block
    client = bigquery.Client(project=settings.writers.project_id)
    
    try:
        # Check logic
        if _table_exists(client):
            logger.info(f"Table already exists: {settings.writers.bq.table_path(settings.writers.project_id)}")
            return

        # Create logic
        _create_table(client)
        
    except Exception as e:
        logger.error(f"Critical error ensuring table infrastructure: {e}")
        # Re-raise to prevent application startup if DB is invalid
        raise
    finally:
        # Always close the client to release resources/sockets
        client.close()