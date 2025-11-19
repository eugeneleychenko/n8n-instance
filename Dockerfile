# Use official n8n image
FROM n8nio/n8n:latest

# Set environment variables for Railway
ENV N8N_HOST=0.0.0.0
ENV N8N_PROTOCOL=https
ENV NODE_ENV=production
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true
ENV GENERIC_TIMEZONE=UTC
ENV TZ=UTC

# Expose port (Railway will map this automatically)
EXPOSE 5678

# Don't override the default n8n entrypoint - it knows how to start properly
# Railway will need to set N8N_PORT=${PORT} as an environment variable
