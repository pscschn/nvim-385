FROM docker.io/redhat/ubi9-minimal:latest

ARG NVIM_VER=0.10.1
ARG JUST_VER=1.33.0
ARG RIPGREP_VER=14.1.0
ARG TMUX_PREFIX="C-b"

COPY container/repos/fedora.repo \
    /etc/yum.repos.d/fedora.repo

# Update the repository cache
RUN microdnf -y install \
    tar \
    gzip \
    tmux ncurses ncurses-libs \
    git \
    clang \
    unzip \
    && microdnf clean all

COPY container/bin/tar /usr/local/bin/tar
RUN chmod +x /usr/local/bin/tar

WORKDIR /usr/local/src/nvim-385

COPY scripts scripts
COPY src src
COPY justfile .

# Install requirements
RUN source scripts/install-all

# configure nvim
RUN just setup && \
    just build && \
    just publish

COPY tmux $XDG_CONFIG_HOME/tmux

COPY container/entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]