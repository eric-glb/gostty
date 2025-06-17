ARG UPX_URL=https://github.com/upx/upx/releases/download/v5.0.1/upx-5.0.1-amd64_linux.tar.xz
ARG PRG=gostty

FROM golang:latest AS prereqs
SHELL ["/bin/bash", "-c"]
ENV DEBIAN_FRONTEND=noninteractive
ARG UPX_URL
RUN apt-get update && \
    apt-get install -y xz-utils && \
    rm -rf /var/lib/apt/lists/* && \
    wget "$UPX_URL" && \
    tar xvfJ "${UPX_URL##*/}"\
      --strip-components=1 \
      -C /usr/local/bin \
      --wildcards "*/upx" && \
    rm -f "${UPX_URL##*/}"

FROM prereqs AS builder
ARG PRG
COPY . /go/src
WORKDIR /go/src
RUN go build -buildvcs=false -o $PRG && upx -9 $PRG

FROM scratch
ARG PRG
COPY --from=builder /go/src/$PRG /$PRG
WORKDIR /
ENTRYPOINT ["/$PRG"]

