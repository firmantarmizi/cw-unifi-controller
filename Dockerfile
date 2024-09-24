# Use the official Unifi Controller image as base
FROM jacobalberty/unifi:latest

# Set environment variable for timezone
ENV TZ='Asia/Jakarta'

# Create necessary directories
RUN mkdir -p /unifi/data /unifi/log

# Set the working directory
WORKDIR /unifi

# Expose necessary ports
EXPOSE 8080 8443 3478/udp

# Set user to run the container
USER unifi

# Command to run the Unifi Controller
CMD ["java", "-Xmx1024M", "-jar", "/usr/lib/unifi/lib/ace.jar", "start"]
