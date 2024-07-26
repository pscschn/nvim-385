#! /bin/zsh
#
# Installs nvim in desired version

set -eu;
echo "Installing nvim...";
echo -ne '                          (0%)\r';
wget -q https://github.com/neovim/neovim/releases/download/${NVIM_VER}/nvim-linux64.tar.gz;
echo -ne '#####                     (25%)\r';
tar --no-same-owner --no-same-permissions -xf nvim-linux64.tar.gz;
echo -ne '#############             (50%)\r';
cp -r nvim-linux64 /usr/local/src/nvim-linux64;
echo -ne '##################        (75%)\r';
ln -s /usr/local/src/nvim-linux64/bin/nvim /usr/bin/nvim;
rm -rf nvim-*;
echo -ne '#######################   (100%)\r';