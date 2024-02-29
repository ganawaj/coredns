#!/bin/bash

BINARY="/output/coredns"
BUILD_SHA=$(docker buildx build . -f build/docker/Dockerfile.build -q)

mkdir -p output

# check plugin.cfg
# docker run --rm \
#   -v "$(pwd)/plugin.cfg:/coredns/plugin.cfg" \
#   "$BUILD_SHA" make check

# build binary
docker run --rm \
  -v "$(pwd)/output:/output" \
  -v "$(pwd)/plugin.cfg:/coredns/plugin.cfg" \
  "$BUILD_SHA" BINARY=$BINARY make