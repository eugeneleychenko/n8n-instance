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

# Install su-exec for user switching in entrypoint
USER root
RUN apk add --no-cache su-exec

# Copy custom entrypoint that fixes volume permissions
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Use custom entrypoint
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD []
