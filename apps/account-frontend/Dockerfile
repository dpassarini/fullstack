FROM node:9.5.0-slim

RUN npm i -g @angular/cli \
&& npm i -g typescript \
&& npm install

ENV INSTALL_PATH /frontend

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY . .