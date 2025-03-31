# docker-fast-cli

[![Build Status](https://github.com/brucewillke/docker-fast-cli/actions/workflows/docker-image.yml/badge.svg)](https://github.com/brucewillke/docker-fast-cli/actions/workflows/docker-image.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/brucewillke/docker-fast-cli)](https://hub.docker.com/r/brucewillke/docker-fast-cli)

> 🐳 Docker container for running [fast-cli](https://github.com/sindresorhus/fast-cli) internet speed tests from the command line — using Puppeteer + Chromium under the hood, with zero setup on your system.

---

## 🚀 Quick Start

### Run the speed test

```bash
docker run --rm brucewillke/docker-fast-cli
```

### Show upload speed

```bash
docker run --rm brucewillke/docker-fast-cli fast -u
```

You can pass any flags supported by `fast-cli`.

---

## 🧰 What's Inside

- ✅ `fast-cli` installed globally
- ✅ `puppeteer` installed globally
- ✅ Chromium (system-installed)
- ✅ Runs as **non-root user**
- ✅ Optimized Ubuntu Slim or Alpine base

---

## 📦 Available Docker Tags

| Tag              | Base OS   | Description                        |
|------------------|-----------|------------------------------------|
| `latest`         | Ubuntu    | Latest Ubuntu-based build          |
| `ubuntu-latest`  | Ubuntu    | Explicit Ubuntu tag                |
| `latest-ubuntu`  | Ubuntu    | Alias for `ubuntu-latest`          |
| `alpine-latest`  | Alpine    | Minimal image (smaller footprint)  |
| `latest-alpine`  | Alpine    | Alias for `alpine-latest`          |

---

## 🛠 Build Locally

Ubuntu-based:

```bash
docker build -t my-fast-cli .
```

Alpine-based:

```bash
docker build -f Dockerfile-alpine -t my-fast-cli:alpine .
```

---

## 🧪 Test Image Locally

```bash
docker run --rm brucewillke/docker-fast-cli fast --version
```

---

## 🔒 Security

This image runs as a non-root user (`docker`) and sets environment variables to ensure Puppeteer uses the system-installed Chromium:

```Dockerfile
ENV PUPPETEER_SKIP_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
```

---

## 🔄 Automated Builds

Images are automatically rebuilt via GitHub Actions:

- ✅ On push to `main`
- ✅ On pull requests changing Dockerfiles
- ✅ On a schedule: **every Sunday at 00:00 UTC**

---

## 📄 License

MIT – free to use, modify, and share.

---

## 🙌 Credits

- [fast-cli](https://github.com/sindresorhus/fast-cli) by @sindresorhus  
- [puppeteer](https://github.com/puppeteer/puppeteer) by the Google Chrome team
