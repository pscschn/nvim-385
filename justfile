#!/usr/bin/env just --justfile

build:
  ./scripts/project/build

publish:
  ./scripts/project/publish

setup:
  ./scripts/project/link-globals # probably requires sudo

install:
  ./scripts/install-all

container action:
  if [ {{action}} = "build" ]; then podman build -t nvim-385 . && podman container create --name nvim --no-start nvim-385 ;fi
  if [ {{action}} = "start" ]; then podman start nvim-385 ;fi

test script:
  nvim -l $(realpath {{script}})