FROM node:current-bullseye
RUN apt-get update
RUN apt-get install libnss3* -y
RUN apt-get install -y chromium
RUN npm install --global fast-cli
CMD [ "fast" ]
