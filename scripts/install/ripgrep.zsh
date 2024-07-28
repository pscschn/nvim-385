#! /bin/zsh
#
# Installs ripgrep which is a line-oriented search tool
# that recursively searches the current directory for a regex pattern
#
# Vars: 
# - RIPGREP_VER: specify the desired ripgrep version
#
# - SRC_DIR: specify directory where ripgrep binaries
#       will be downloaded to ! without a trailing slash !

set -eu;

: "${RIPGREP_VER:=14.1.0}"
: "${SRC_DIR:=/usr/local/src}"

if [ ! -d "$SRC_DIR" ]; then
  mkdir -p "$SRC_DIR"
fi

echo "Installing ripgrep ${RIPGREP_VER}...";
echo -ne '[                                                       ] (0%)\r';
curl -sL \
    https://github.com/BurntSushi/ripgrep/releases/download/${RIPGREP_VER}/ripgrep-${RIPGREP_VER}-x86_64-unknown-linux-musl.tar.gz | \
    tar -xz -C "$SRC_DIR" && \
    mv "$SRC_DIR"/ripgrep-${RIPGREP_VER}-x86_64-unknown-linux-musl "$SRC_DIR"/ripgrep;

echo -ne '[###########################                            ] (50%)\r';
ln -s "$SRC_DIR"/ripgrep/rg /usr/bin/rg;
echo -ne '[#######################################################] (100%)\r\n';