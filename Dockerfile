# Use a multi-stage build to minimize the final image size
FROM node:21.7.0-bullseye-slim as builder

# Install dependencies required for the build
RUN apt-get update && \
    apt-get install -y --no-install-recommends libnss3* chromium && \
    rm -rf /var/lib/apt/lists/*

# Install fast-cli globally
RUN npm install -g meow
RUN npm install -g fast-cli

# Final stage: Use a slim base image
FROM node:21.7.0-bullseye-slim

# Create a non-root user
RUN useradd -m docker

# Copy the installed fast-cli from the builder stage
COPY --from=builder /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=builder /usr/local/bin/fast /usr/local/bin/fast

# Set permissions for the non-root user
RUN chown -R docker:docker /usr/local/lib/node_modules

# Switch to the non-root user
USER docker

# Set the working directory
WORKDIR /home/docker/app

# Set the default command
CMD [ "fast", "-u" ]
