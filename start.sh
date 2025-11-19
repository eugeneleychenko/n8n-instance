#!/bin/sh

# Railway provides PORT env variable, but n8n uses N8N_PORT
# If PORT is set by Railway, use it for N8N_PORT
if [ -n "$PORT" ]; then
    export N8N_PORT=$PORT
fi

# Ensure N8N_PORT has a default if neither is set
export N8N_PORT=${N8N_PORT:-5678}

echo "Starting n8n on port $N8N_PORT"

# Start n8n
exec n8n start

