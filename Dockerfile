# Use official n8n image
FROM n8nio/n8n:latest

# Switch to root to copy files
USER root

# Copy our entrypoint wrapper
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Set environment variables for Railway
ENV N8N_HOST=0.0.0.0
ENV N8N_PROTOCOL=https
ENV NODE_ENV=production
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true
ENV GENERIC_TIMEZONE=UTC
ENV TZ=UTC

# Switch back to node user
USER node

# Expose port (Railway will map this automatically)
EXPOSE 5678

# Use our wrapper entrypoint
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["start"]
