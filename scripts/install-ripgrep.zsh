#! /bin/zsh
#
# Installs ripgrep which is a line-oriented search tool
# that recursively searches the current directory for a regex pattern

set -eu;
echo "Installing ripgrep...";
echo -ne '                          (0%)\r';
wget -q https://github.com/BurntSushi/ripgrep/releases/download/${RIPGREP_VER}/ripgrep-${RIPGREP_VER}-x86_64-unknown-linux-musl.tar.gz;
echo -ne '#####                     (25%)\r';
tar --no-same-owner --no-same-permissions -xf ripgrep-${RIPGREP_VER}-x86_64-unknown-linux-musl.tar.gz;
echo -ne '#############             (50%)\r';
cp -r ripgrep-${RIPGREP_VER}-x86_64-unknown-linux-musl /usr/local/src/ripgrep-${RIPGREP_VER};
echo -ne '##################        (75%)\r';
ln -s /usr/local/src/ripgrep-${RIPGREP_VER}/rg /usr/bin/rg;
rm -rf ripgrep-*;
echo -ne '#######################   (100%)\r';