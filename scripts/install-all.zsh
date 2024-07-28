#! /bin/zsh
#
# Runs the scripts inside ./install

: "${ROOT_DIR:=$(pwd)}"

source $ROOT_DIR/scripts/install/nvim.zsh
source $ROOT_DIR/scripts/install/ripgrep.zsh
source $ROOT_DIR/scripts/install/just.zsh