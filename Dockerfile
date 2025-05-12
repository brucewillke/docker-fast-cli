#This is a WIP
# Use a Debian slim-based Node image
FROM node:24.0.1-slim

# Install dependencies and Chromium
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    chromium \
    libnss3 \
    ca-certificates \
    fonts-liberation && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create a non-root user and set up permissions
RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
RUN mkdir -p /home/docker/app/node_modules && chown -R docker:docker /home/docker/app

# Set environment variables for Puppeteer to use system-installed Chromium
ENV PUPPETEER_SKIP_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Install npm packages globally as root (using --unsafe-perm to prevent permission issues)
RUN npm install -g fast-cli puppeteer --unsafe-perm
RUN npm --version
# Switch to the non-root user
USER docker
WORKDIR /home/docker/app

# Set the default command
CMD ["fast", "-u"]

