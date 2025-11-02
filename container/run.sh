#! /bin/bash
#
# Build and run

set -ex

podman build \
  -f https://raw.githubusercontent.com/pscschn/nvim-385/refs/heads/master/container/Dockerfile \
  -t nvim-385 . && \
podman run \
  --replace -it \
  --name nvim-385 \
  -v ./:/mnt/ \
  localhost/nvim-385 bash -c nvim