FROM ruby:2.5.0-slim-stretch

RUN apt-get update && apt-get install -qq -y build-essential default-libmysqlclient-dev libxslt-dev libxml2-dev

ENV INSTALL_PATH /app

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile Gemfile

COPY Gemfile.lock Gemfile.lock

RUN bundle install

WORKDIR $INSTALL_PATH

COPY . .
