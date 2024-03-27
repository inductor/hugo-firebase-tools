# syntax=docker/dockerfile:1.4
FROM alpine:3.18 AS hugo-build
WORKDIR /var
ENV HUGO_VERSION 0.110.0
# Install HUGO
RUN set -x && \
  apk add --update wget ca-certificates && \
  wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
  tar xzf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz

FROM node:18.20.0-alpine AS node
RUN apk add --update git
RUN npm install --production -g firebase-tools
COPY --link --from=hugo-build /var/hugo /usr/bin/hugo
