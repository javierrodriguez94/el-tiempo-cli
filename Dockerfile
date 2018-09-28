FROM alpine:3.2 
MAINTAINER Javier Rodríguez <javier.ri94@outlook.com>

ENV BUILD_PACKAGES curl-dev ruby-dev build-base
ENV Tiempo::HOST "http://api.tiempo.com/index.php?"
ENV Tiempo::API_LANG "es"
ENV Tiempo::DIVISION 102
ENV PATH="${PATH}:/usr/app"


# Update and install base packages
RUN apk update && apk upgrade && apk add bash $BUILD_PACKAGES

# Install ruby and ruby-bundler
RUN apk add ruby ruby-bundler

# Clean APK cache
RUN rm -rf /var/cache/apk/*

RUN mkdir /usr/app 
WORKDIR /usr/app

COPY Gemfile /usr/app/ 
COPY Gemfile.lock /usr/app/ 
RUN bundle install

COPY . /usr/app
