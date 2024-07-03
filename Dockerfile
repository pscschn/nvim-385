FROM docker.io/fedora

ARG NVIM_VER=v0.9.5
ARG TMUX_PREFIX="C-b"

RUN update-ca-trust
# dnf --setopt=sslverify=0 -y update && \
RUN dnf --setopt=sslverify=0 -y install git \ 
    wget \
    tmux \
    ripgrep \
    gcc;

WORKDIR /tmp

RUN set -eu && \
    echo "Installing nvim..." && \
    wget -q https://github.com/neovim/neovim/releases/download/${NVIM_VER}/nvim-linux64.tar.gz && \
    tar --no-same-owner --no-same-permissions -xf nvim-linux64.tar.gz && \
    cp -r nvim-linux64 /usr/local/src/nvim-linux64 && \
    ln -s /usr/local/src/nvim-linux64/bin/nvim /usr/bin/nvim && \
    rm -rf nvim-*;
#RUN chmod +x /usr/share/src/nvim-linux64/bin/nvim

RUN set -e && \
    echo "CloningInstalling nvim-385 preset..." && \
    git clone https://github.com/pscschn/nvim-385 && \
    chmod +x ./nvim-385/install.zsh && \
    source /tmp/nvim-385/install.zsh;

#CMD ["zsh", "/tmp/nvim-385/configure-tmux.zsh"]
#ENTRYPOINT ["tail", "-f", "/dev/null"]
CMD ["nvim", "~"]
