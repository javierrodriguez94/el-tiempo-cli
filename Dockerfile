FROM alpine:3.2 
MAINTAINER Javier Rodríguez <javier.ri94@outlook.com>

ENV BUILD_PACKAGES curl-dev ruby-dev build-base
ENV Tiempo::HOST "http://api.tiempo.com/index.php?"
ENV Tiempo::API_LANG "es"
ENV Tiempo::DIVISION 102
ENV PATH="${PATH}:/usr/app"

RUN apk update && apk upgrade && apk add bash $BUILD_PACKAGES
RUN apk add ruby ruby-bundler
RUN mkdir /usr/app 

WORKDIR /usr/app

COPY . /usr/app
RUN bundle install
