#! /bin/zsh 
#
# Creates symlink for src/globals
# to use containing lua scripts globally

: "${ROOT_DIR:=$(pwd)}"

mkdir -p /usr/local/share/lua/5.1/
ln -sT $ROOT_DIR/src/global /usr/local/share/lua/5.1/nvim-385