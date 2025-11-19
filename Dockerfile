# Use official n8n image
FROM n8nio/n8n:latest

# Set environment variables for Railway
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=https
ENV NODE_ENV=production
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true
ENV GENERIC_TIMEZONE=UTC
ENV TZ=UTC

# Expose port (Railway will map this automatically)
EXPOSE 5678

# Railway provides PORT env variable, but n8n uses N8N_PORT
# We'll handle this with a simple shell command
CMD sh -c "export N8N_PORT=\${PORT:-5678} && n8n start"
