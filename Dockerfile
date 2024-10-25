FROM node:19.7-bullseye-slim

USER root

# Install dependencies and Chromium
RUN apt-get update && \
    apt-get install -y --no-install-recommends sudo libnss3 chromium ca-certificates fonts-liberation && \
    rm -rf /var/lib/apt/lists/*

# Create a non-root user and set up permissions
RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
RUN mkdir -p /home/docker/app/node_modules && chown -R docker:docker /home/docker/app

# Set environment variables for Puppeteer to use system-installed Chromium
ENV PUPPETEER_SKIP_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Install npm packages globally as root
RUN npm install -g fast-cli puppeteer

# Switch back to non-root user
USER docker
WORKDIR /home/docker/app

# Set the default command
CMD ["fast", "-u"]

