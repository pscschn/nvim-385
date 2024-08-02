#!/usr/bin/env just --justfile

PS := "./scripts/project" # project scripts
CS := "./scripts/container" # container scripts

build:
  {{PS}}/build

publish:
  {{PS}}/publish

setup:
  {{PS}}/link-globals # probably requires sudo

install:
  ./scripts/install-all

container action:
  if [ {{action}} = "build" ]; then {{CS}}/build && {{CS}}/create; fi
  if [ {{action}} = "start" ]; then {{CS}}/start; fi
  if [ {{action}} = "bash" ]; then {{CS}}/bash; fi

test script:
  nvim -l $(realpath {{script}})