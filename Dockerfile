FROM jacobalberty/unifi

# Set timezone
ENV TZ='Asia/Jakarta'

# Create necessary directories
RUN mkdir -p /unifi/data /unifi/log

# Set user to root temporarily to ensure we have permissions to modify the image
USER root

# Install any additional packages if needed (uncomment if required)
# RUN apt-get update && apt-get install -y <package-name>

# Create a startup script
RUN echo '#!/bin/bash\n\
mkdir -p /unifi/data /unifi/log\n\
chown -R unifi:unifi /unifi\n\
exec gosu unifi /usr/local/bin/docker-entrypoint.sh "$@"' > /startup.sh && \
    chmod +x /startup.sh

# Expose ports
EXPOSE 8080 8443 3478/udp

# Set volumes
VOLUME ["/unifi"]

# Use the startup script as the entrypoint
ENTRYPOINT ["/startup.sh"]

# Set command
CMD ["unifi"]
