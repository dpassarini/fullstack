FROM node:9.5.0-slim

RUN apt-get update

RUN apt-get install python -y

ENV INSTALL_PATH /frontend

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY package.json ./

RUN npm install @angular/cli --save \
&& npm install typescript --save \
&& npm install --save

COPY . .

CMD [ "npm", "start" ]