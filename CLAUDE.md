# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

docker-fast-cli is a Docker containerization of [fast-cli](https://github.com/sindresorhus/fast-cli) (internet speed test). It provides two image variants: Ubuntu slim (`Dockerfile`) and Alpine (`Dockerfile-alpine`), both running as a non-root `docker` user with system Chromium via Puppeteer.

## Build & Run Commands

```bash
# Build Ubuntu variant
docker build -t docker-fast-cli .

# Build Alpine variant
docker build -f Dockerfile-alpine -t docker-fast-cli:alpine .

# Run speed test
docker run --rm docker-fast-cli

# Test image (used in CI)
docker run --rm docker-fast-cli fast --version          # Ubuntu
docker run --rm docker-fast-cli:alpine npx fast --version  # Alpine
```

## Architecture

- **No application source code** — this is a pure Docker project wrapping existing npm packages (`fast-cli`, `puppeteer`) with system Chromium.
- **Ubuntu variant** (`Dockerfile`): Installs packages globally, runs via `CMD ["fast", "-u"]`.
- **Alpine variant** (`Dockerfile-alpine`): Installs packages locally, runs via `CMD ["npx", "fast", "-u"]`.
- Both set `PUPPETEER_SKIP_DOWNLOAD=true` and `PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium` to use system Chromium instead of downloading it.

## CI/CD

GitHub Actions workflow (`.github/workflows/docker-image.yml`) builds and publishes both variants to Docker Hub (`brucewillke/docker-fast-cli`). Triggers: push to main, PRs, weekly schedule (Sunday 00:00 UTC), manual dispatch. Dependabot manages base image and Actions version updates.
