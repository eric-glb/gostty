ARG UPX_URL=https://github.com/upx/upx/releases/download/v5.0.1/upx-5.0.1-amd64_linux.tar.xz

FROM golang:latest AS prereqs
SHELL ["/bin/bash", "-c"]
ENV DEBIAN_FRONTEND=noninteractive
ARG UPX_URL
RUN apt-get update && \
    apt-get install -y xz-utils && \
    wget "$UPX_URL" && \
    tar xvfJ "${UPX_URL##*/}"\
      --strip-components=1 \
      -C /usr/local/bin \
      --wildcards "*/upx"

FROM prereqs AS builder
COPY . /go/src
WORKDIR /go/src
RUN CGO_ENABLED=1 go build --ldflags '-linkmode=external -extldflags=-static' && \
    upx -9 gostty

FROM scratch
COPY --from=builder /go/src/gostty /gostty
WORKDIR /
CMD ["/gostty"]

