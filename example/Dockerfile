FROM golang:1.14-alpine

LABEL maintainer="Bo-Yi Wu <appleboy.tw@gmail.com>"

RUN apk add bash ca-certificates git gcc g++ libc-dev
WORKDIR /app
# Force the go compiler to use modules
ENV GO111MODULE=on
# We want to populate the module cache based on the go.{mod,sum} files.
COPY go.mod .
COPY go.sum .
COPY main.go .

ENV GOOS=linux
ENV GOARCH=amd64
RUN go build -o /app -tags netgo -ldflags '-w -extldflags "-static"' .

CMD ["/app"]
