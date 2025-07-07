# The base n8n image
FROM n8nio/n8n

# Temporarily switch to the root user to install the proxy
USER root

# Download the Cloud SQL Proxy and make it executable
RUN wget https://storage.googleapis.com/cloudsql-proxy/v1.28.0/cloud_sql_proxy.linux.amd64 -O /usr/local/bin/cloud_sql_proxy && \
    chmod +x /usr/local/bin/cloud_sql_proxy

# Copy the startup script
COPY ./docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Switch back to the non-root user for security
USER node

# Set the new entrypoint
ENTRYPOINT ["/docker-entrypoint.sh"]
