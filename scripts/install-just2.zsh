#! /bin/zsh
#
# Installs just which is just a command runner

set -eu;
echo "Installing just...";
echo -ne '                          (0%)\r';
mkdir -p ~/bin && \
echo -ne '#####                     (33%)\r';
wget -qO- https://just.systems/install.sh | bash -s -- --to ~/bin && \
echo -ne '#############             (66%)\r';
export PATH="$PATH:$HOME/bin"
echo -ne '##################        (100%)\r';
