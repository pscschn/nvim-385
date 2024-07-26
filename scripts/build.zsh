#! /bin/zsh
#
# builds the nvim config

rm -rf .build
nvim -l src/build.lua