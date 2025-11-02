FROM docker.io/debian:stable-slim
ARG VERSION=0.11.4

RUN apt-get update && \
  apt-get -y install curl git

WORKDIR /tmp

RUN /usr/bin/curl -sSL -o nvim-linux-x86_64.tar.gz \
  https://github.com/neovim/neovim/releases/download/v${VERSION}/nvim-linux-x86_64.tar.gz && \
  tar -xf nvim-linux-x86_64.tar.gz && \
  cp -r nvim-linux-x86_64/* /usr/local/ && \
  rm -rf *

RUN mkdir -p ~/.config/nvim && \
  git clone https://github.com/pscschn/nvim-385 ~/.config/nvim

WORKDIR /mnt