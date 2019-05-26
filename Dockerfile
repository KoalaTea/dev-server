FROM python:3.7 as python

FROM golang:1.12.0 as golang

FROM node:12.3.1 as node

FROM codercom/code-server

USER root
COPY --from=python /usr/local/ /usr/local/
COPY --from=golang /usr/local/ /usr/local/
COPY --from=node /usr/local/ /usr/local
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
	code-server --install-extension ms-vscode.go && \
	code-server --install-extension ryanluker.vscode-coverage-gutters && \
	code-server --install-extension peterjausovec.vscode-docker && \
	code-server --install-extension dbaeumer.vscode-eslint

COPY vscode.json /home/coder/.local/share/code-server/User/settings.json
#COPY vscode.json /home/coder/.config/Code/User/settings.json

ENTRYPOINT ["dumb-init", "code-server"]