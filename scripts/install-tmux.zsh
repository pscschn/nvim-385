#! /bin/zsh
#
# Installs tmux which is a line-oriented search tool
# that recursively searches the current directory for a regex pattern
#
# Vars: 
# - TMUX_VER: specify the desired tmux version
#
# - SRC_DIR: specify directory where tmux binaries
#       will be downloaded to ! without a trailing slash !

: "${TMUX_VER:=3.4-1}"
: "${SRC_DIR:=/usr/local/src/tmux}"

if [ ! -d "$SRC_DIR" ]; then
  mkdir -p "$SRC_DIR"
fi

set -eu;
echo "Installing tmux ${TMUX_VER}...";

echo -ne '[                                                       ] (0%)\r';

curl -sL \
        https://dl.fedoraproject.org/pub/fedora/linux/releases/40/Everything/x86_64/os/Packages/t/tmux-${TMUX_VER}.fc40.x86_64.rpm \
    -o /tmp/tmux-${TMUX_VER}.fc40.x86_64.rpm;

echo -ne '[###########################                            ] (50%)\r';

rpm -i /tmp/tmux-${TMUX_VER}.fc40.x86_64.rpm;
rm -f /tmp/tmux-${TMUX_VER}.fc40.x86_64.rpm;
echo -ne '[#######################################################] (100%)\r\n';