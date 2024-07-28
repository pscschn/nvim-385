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
    bash \
    ncurses ncurses-dev ncurses-libs ncurses-terminfo \
    make \
    cmake; 

WORKDIR /usr/local/src/nvim-385

COPY scripts scripts
COPY src src
COPY justfile .
    
# Install requirements
RUN source scripts/install-all.zsh && \
    just setup;


ENTRYPOINT ["tail", "-f", "/dev/null"]
#RUN source ./install-tmux.zsh