FROM python:3.7-alpine3.9 as python

FROM golang:1.12.0-alpine3.9 as golang

FROM alpine:3.9


COPY --from=python /usr/local/ /usr/local/
COPY --from=golang /usr/local/ /usr/local/

RUN apk add --no-cache ca-certificates \
    git \
    bash \
    libffi-dev \
    openssl-dev \
    bzip2-dev \
    zlib-dev \
    readline-dev \
    sqlite-dev \
    build-base \
    linux-headers

ENV PATH /usr/local/go/bin:$PATH
ENV GO111MODULE auto
ENV GOPATH /go
RUN mkdir -p "/go" && mkdir -p "$GOPATH/src" "$GOPATH/bin" "$GOPATH/pkg" && chmod -R 777 "$GOPATH"


CMD ["/bin/ash"]