# Use a slim base image
FROM node:21.7.0-bookworm-slim

# Create a non-root user and set the home directory
RUN useradd -m docker

# Install necessary dependencies for Puppeteer
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libglib2.0-0 \
        libnss3 \
        libnspr4 \
        libatk1.0-0 \
        libatk-bridge2.0-0 \
        libcups2 \
        libdbus-1-3 \
        libdrm2 \
        libxkbcommon0 \
        libxcomposite1 \
        libxdamage1 \
        libxrandr2 \
        libgbm1 \
        libpango-1.0-0 \
        libcairo2 \
        libasound2 \
        libatspi2.0-0 \
        libxshmfence1 \
        libxfixes3 && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory to the user's home directory
WORKDIR /home/docker

# Install fast-cli locally
RUN npm install fast-cli

# Set permissions for the non-root user
RUN chown -R docker:docker /home/docker

# Switch to the non-root user
USER docker

# Add the local node_modules/.bin to the PATH
ENV PATH="/home/docker/node_modules/.bin:${PATH}"

# Set the default command
CMD [ "fast", "-u" ]
