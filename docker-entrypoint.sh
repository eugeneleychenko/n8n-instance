#!/bin/bash

# Railway provides PORT, but n8n uses N8N_PORT
if [ -n "$PORT" ]; then
    export N8N_PORT=$PORT
fi

# Set default if neither is set
export N8N_PORT=${N8N_PORT:-5678}

echo "Starting n8n on port $N8N_PORT"

# Execute n8n with all arguments passed to this script
exec n8n "$@"

