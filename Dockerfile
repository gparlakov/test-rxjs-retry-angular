# Base image
FROM node:14

# Maintainer name
LABEL maintainer="educative@educative.io"

# Install Google Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN apt-get update && apt-get install -y google-chrome-stable

RUN npm install -g @angular/cli

# set the workdir to be the Educative directory
WORKDIR /usr/local/educative/angular

ADD package.json ./package.json
# Installing Angular cli and node modules in angular directory
RUN cd /usr/local/educative/angular && npm i

# Copying angular folder from local directory to Educative directory
COPY . .

ENTRYPOINT npm test

EXPOSE 3000
EXPOSE 4200
EXPOSE 9876
