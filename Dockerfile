FROM ruby:2.6.3-alpine
MAINTAINER operations@blinkist.com

LABEL APP_NAME=deploymentblocker

ENV BUILD_PACKAGES build-base git
ENV RUNTIME_PACKAGES mysql-dev nodejs nodejs-npm tzdata
ENV RAILS_ENV=production APP_NAME=deploymentblocker LANG=C.UTF-8 LANGUAGE=C.UTF-8 LC_ALL=C.UTF-8 LC_CTYPE=C.UTF-8

ARG SECRET_KEY_BASE=fake
ARG AIRBRAKE_PROJECT_ID=
ARG AIRBRAKE_PROJECT_KEY=
ARG BUNDLE_GITHUB__COM

RUN mkdir /app && echo 'gem: --no-document' >> ~/.gemrc

WORKDIR /app
COPY Gemfile* /app/
COPY .ruby-version /app/

RUN apk update && \
    apk upgrade && \
    apk add $BUILD_PACKAGES && \
    apk add $RUNTIME_PACKAGES && \
    rm -rf /var/cache/apk/*

RUN bundle install --jobs 20 --retry 5 --without development test && \
    npm install --global yarn && \
    apk del $BUILD_PACKAGES

ADD . /app

RUN mkdir /nonexistent

RUN bundle exec rake assets:precompile assets:clean

RUN chown -R nobody:nogroup /app /nonexistent

USER nobody

EXPOSE 3000

CMD bundle exec rails s -p 3000 -b '0.0.0.0'
