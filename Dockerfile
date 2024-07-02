FROM docker.io/fedora

USER 1000

ARG NVIM_VER=v0.9.5
ARG TMUX_PREFIX="C-b"

RUN dnf -y update && \
    dnf -y install git \
    wget \
    tmux \
    zsh \
    ripgrep \
    gcc;

WORKDIR /tmp

RUN set -e && \
    echo "Cloning nvim-385 repository..." && \
    git clone https://github.com/pscschn/nvim-385 && \
    chmod +x ./nvim-385/install.zsh;

RUN set -eu && \
    echo "Installing nvim..." && \
    wget -q https://github.com/neovim/neovim/releases/download/${NVIM_VER}/nvim-linux64.tar.gz && \
    tar -xf nvim-linux64.tar.gz && \
    cp -r nvim-linux64 /usr/local/src/nvim-linux64 && \
    ln -s /usr/local/src/nvim-linux64/bin/nvim /usr/bin/nvim && \
    rm -rf nvim-*;
#RUN chmod +x /usr/share/src/nvim-linux64/bin/nvim


RUN echo "Installing nvim-385 preset" && \
    cd /tmp/nvim-385/ && \
    zsh ./install.zsh;

#CMD ["zsh", "/tmp/nvim-385/configure-tmux.zsh"]
#ENTRYPOINT ["tail", "-f", "/dev/null"]
CMD ["nvim", "~"]
