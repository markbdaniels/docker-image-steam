
FROM node:11.7.0-alpine


ARG isteam_config=isteam_config
ENV isteam_config=$isteam_config

# python
RUN apk add --update \
  python \
  py-pip \
  build-base \
  && pip install virtualenv \
  && rm -rf /var/cache/apk/*


# Create app directory
WORKDIR /usr/src/app

# copy config files
COPY $isteam_config ./config.json

# https://github.com/nodejs/docker-node/blob/master/docs/BestPractices.md#global-npm-dependencies
USER node
RUN mkdir /home/node/.npm-global
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH=$PATH:/home/node/.npm-global/bin 

RUN npm install -g sharp
RUN npm install -g image-steam
RUN npm install -g image-steam-s3

# Expose port
EXPOSE 13337

# Launch
CMD [ "isteam", "--isConfig", "./config.json"]
