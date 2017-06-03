FROM ruby:2.4.1-alpine

LABEL maintainer="https://github.com/ashphy/baku" \
      description="Share all knowledge, devour it."

ENV RAILS_ENV=production \
    NODE_ENV=production

EXPOSE 3000 4000

WORKDIR /baku

RUN echo "@edge https://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
 && BUILD_DEPS=" \
    libxml2-dev \
    libxslt-dev \
    build-base" \
 && apk -U upgrade && apk add \
    $BUILD_DEPS \
    git \
    libxml2 \
    libxslt \
    ca-certificates \
 && update-ca-certificates \
 && rm -rf /tmp/* /var/cache/apk/*

COPY Gemfile Gemfile.lock /baku/

RUN bundle install --deployment --without test development

COPY . /baku

VOLUME /baku/public/system /baku/public/assets /baku/public/packs
