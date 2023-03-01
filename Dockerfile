FROM node:19.7-bullseye-slim
USER root
RUN apt-get update
RUN apt-get -y install sudo libnss3* chromium --no-install-recommends
RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
RUN mkdir -p /home/docker/app/node_modules && chown -R docker:docker /home/docker/app
WORKDIR /home/docker/app
RUN npm install -g fast-cli
RUN rm -rf /var/lib/apt/lists/*

USER docker
WORKDIR /home/docker/app
CMD [ "fast", "-u"  ]
