FROM node:current-bullseye
USER root
RUN apt-get update
RUN apt-get -y install sudo
RUN apt-get install libnss3* -y
RUN apt-get install -y chromium
RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
RUN mkdir -p /home/docker/app/node_modules && chown -R docker:docker /home/docker/app
WORKDIR /home/docker/app
RUN npm install -g fast-cli

USER docker
WORKDIR /home/docker/app
CMD [ "fast", "-u"  ]
