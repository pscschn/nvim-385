#! /bin/zsh
#
# Builds and installs tmux which is a
# terminal multiplexer
set -eu

: "${SRC_DIR:=/usr/local/src}"
TMUX_SRC="$SRC_DIR"/tmux

if [ ! -d "$TMUX_SRC" ]; then
  mkdir -p "$TMUX_SRC"
fi

git clone https://github.com/tmux/tmux.git "$TMUX_SRC"
cd "$TMUX_SRC"
sh autogen.sh
./configure
make && sudo make install