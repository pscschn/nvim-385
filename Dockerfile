FROM docker.io/alpine:latest

ARG TMP_DIR=/tmp
ARG NVIM_VER=0.9.5
ARG RIPGREP_VER=14.1.0
ARG TMUX_PREFIX="C-b"
ARG BASE_ARCH=x86_64

# Update the repository cache
RUN apk add \
    tar \
    gzip \ 
    tmux \
    curl \
    bash; 

WORKDIR ${TMP_DIR}/nvim-385
COPY scripts scripts

# Install requirements
WORKDIR ${TMP_DIR}/nvim-385/scripts/install

RUN source ./install-nvim.zsh && \
    source ./install-ripgrep.zsh && \
    source ./install-just.zsh

#RUN source ./install-tmux.zsh