# Use official n8n image
FROM n8nio/n8n:latest

# Switch to root to install dependencies and set permissions
USER root

# Set working directory
WORKDIR /home/node

# Copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Set environment variables for Railway
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=https
ENV NODE_ENV=production
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true
ENV GENERIC_TIMEZONE=UTC
ENV TZ=UTC

# Switch back to node user for security
USER node

# Expose port (Railway will map this automatically)
EXPOSE 5678

# Use our custom startup script
CMD ["/start.sh"]
