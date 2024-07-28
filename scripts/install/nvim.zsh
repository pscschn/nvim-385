#! /bin/zsh
#
# Installs nvim in desired version
#
# Vars: 
# - NVIM_VER: specify the desired nvim version
#
# - SRC_DIR: specify directory where nvim binaries
#       will be downloaded to ! without a trailing slash !

: "${NVIM_VER:=0.9.5}"
: "${SRC_DIR:=/usr/local/src}"

if [ ! -d "$SRC_DIR" ]; then
  mkdir -p "$SRC_DIR"
fi

set -eu;
echo "Installing nvim ${NVIM_VER}...";
echo -ne '[                                                       ] (0%)\r';
curl -sL https://github.com/neovim/neovim/releases/download/v${NVIM_VER}/nvim-linux64.tar.gz | tar -xz -C "$SRC_DIR";
echo -ne '[###########################                            ] (50%)\r';
ln -s "$SRC_DIR"/nvim-linux64/bin/nvim /usr/bin/nvim;
export PATH="$SRC_DIR/nvim-linux64/bin:$PATH"
echo -ne '[#######################################################] (100%)\r\n';