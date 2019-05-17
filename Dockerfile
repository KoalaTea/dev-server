FROM python:3.7 as python

FROM golang:1.12.0 as golang

FROM codercom/code-server

USER root
COPY --from=python /usr/local/ /usr/local/
COPY --from=golang /usr/local/ /usr/local/
RUN apt-get update && apt-get install -y ca-certificates \
	git \
	bash \
	libunwind8

#COPY --from=python /lib/ /lib/


ENV PATH /usr/local/go/bin:$PATH
ENV GO111MODULE auto
ENV GOPATH /go
#RUN mkdir -p "/go" && mkdir -p "$GOPATH/src" "$GOPATH/bin" "$GOPATH/pkg" && chmod -R 777 "$GOPATH"

ENTRYPOINT ["dumb-init", "code-server"]