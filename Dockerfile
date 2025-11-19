# Use official n8n image
FROM n8nio/n8n:latest

# Set environment variables for Railway
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=https
ENV NODE_ENV=production

# Expose port
EXPOSE 5678

# Start n8n using node
CMD ["node", "/usr/local/bin/n8n"]
