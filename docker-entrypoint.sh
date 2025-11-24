#!/bin/sh
set -e

# Fix permissions on the volume mount if needed
if [ -d "/home/node/.n8n" ]; then
  echo "Fixing permissions on /home/node/.n8n..."
  chown -R node:node /home/node/.n8n 2>/dev/null || true
  chmod -R u+w /home/node/.n8n 2>/dev/null || true
fi

# Switch to node user and run n8n
exec su-exec node n8n "$@"
