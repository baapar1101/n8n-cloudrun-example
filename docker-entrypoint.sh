#!/bin/sh

# Immediately exit if any command fails.
set -e

# 1. Start the Cloud SQL Auth Proxy in the background.
#    The proxy will listen for connections and forward them to your Cloud SQL instance.
#    The "&" is crucial for running it as a background process.
echo "INFO: Starting Cloud SQL Auth Proxy..."
/usr/local/bin/cloud_sql_proxy -instances=${DB_INSTANCE_CONNECTION_NAME}=tcp:5432 &

# 2. Execute the main n8n process.
#    We use 'exec' to replace this script with the n8n process. This is critical
#    for Cloud Run to properly manage the container lifecycle and signals.
#    n8n will automatically listen on the $PORT environment variable set by Cloud Run.
echo "INFO: Starting n8n..."
exec n8n
