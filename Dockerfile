FROM --platform=$BUILDPLATFORM golang:1.26.8-alpine AS build
ARG TARGETOS
ARG TARGETARCH
RUN apk add --no-cache git
WORKDIR /src
ADD --checksum=sha256:3792db304df1b7e0a06b6dc18230c131c28f0e283d8088ccb7d83da3bf549304 https://codeload.github.com/appleboy/drone-docker/tar.gz/b26b4b95ae0e1c23f6cf75b98eedbabe29d366eb /tmp/source.tar.gz
RUN tar -xzf /tmp/source.tar.gz --strip-components=1 -C /src
# Preserve the fork commit while correcting its invalid pseudo-version timestamp.
RUN go mod edit -replace github.com/urfave/cli=github.com/bradrydzewski/cli@v0.0.0-20170424184348-0d51abd87c77 && CGO_ENABLED=0 GOOS=$TARGETOS GOARCH=$TARGETARCH go build -mod=mod -trimpath -o /out/drone-ecr ./cmd/drone-ecr && CGO_ENABLED=0 GOOS=$TARGETOS GOARCH=$TARGETARCH go build -mod=mod -trimpath -o /out/drone-docker ./cmd/drone-docker
FROM docker:29.8.2-dind
ENV DOCKER_HOST=unix:///var/run/docker.sock
COPY --from=build /out/drone-ecr /out/drone-docker /bin/
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
