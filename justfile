#!/usr/bin/env just --justfile

build:
  source scripts/project/build.zsh

publish:
  source scripts/project/publish.zsh

setup: 
  source scripts/project/link-globals.zsh

install:
  source scripts/install-all.zsh

container action:
  if [ {{action}} = "build" ]; then podman build -t nvim-385 . ;fi

test script:
  nvim -l $(realpath {{script}})