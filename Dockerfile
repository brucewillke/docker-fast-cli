# Use a Debian slim-based Node image
FROM node:26.7.0-slim

# Install dependencies, Chromium, create non-root user, and install npm packages in one layer
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    chromium \
    libnss3 \
    ca-certificates \
    fonts-liberation && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    useradd -m docker && \
    mkdir -p /home/docker/app/node_modules && \
    chown -R docker:docker /home/docker/app

# Set environment variables for Puppeteer to use system-installed Chromium
ENV PUPPETEER_SKIP_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Install npm packages globally and clean cache
RUN npm install -g fast-cli puppeteer --unsafe-perm && \
    npm cache clean --force

# Switch to the non-root user
USER docker
WORKDIR /home/docker/app

# Print startup message then run the command
ENTRYPOINT ["sh", "-c", "echo 'Starting speed test...' && exec \"$@\"", "--"]
CMD ["fast", "-u"]

