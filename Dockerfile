FROM alpine:3.7 AS hugo-build
WORKDIR /var
ENV HUGO_VERSION 0.44
# Install HUGO
RUN set -x && \
  apk add --update wget ca-certificates && \
  wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
  tar xzf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz

FROM node:alpine AS node
WORKDIR /usr/bin
RUN apk --update add git openssh && \
  rm -rf /var/lib/apt/lists/* && \
  rm /var/cache/apk/*
COPY --from=hugo-build /var/hugo /usr/bin/hugo
RUN npm install -g firebase-tools
