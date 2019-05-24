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

RUN mkdir -p "/go" && mkdir -p "/go/src" "/go/bin" "/go/pkg" && chmod -R 777 "/go"
USER coder

ENV PATH /usr/local/go/bin:$PATH
ENV GO111MODULE auto
ENV GOPATH /go

RUN code-server --install-extension ms-python.python && \
	code-server --install-extension ms-vscode.go

COPY vscode.json /home/coder/.config/Code/User/settings.json

ENTRYPOINT ["dumb-init", "code-server"]