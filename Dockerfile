FROM alpine:3.11 AS hugo-build
WORKDIR /var
ENV HUGO_VERSION 0.62.0
# Install HUGO
RUN set -x && \
  apk add --update wget ca-certificates && \
  wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
  tar xzf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz

FROM node:12.14.0-alpine AS node
WORKDIR /usr/bin
COPY --from=hugo-build /var/hugo /usr/bin/hugo
RUN apk --update --no-cache add git openssh && \
  npm install -g firebase-tools
