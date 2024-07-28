#! /bin/zsh
#
# Installs just which is just a command runner

set -eu;

echo "Installing just...";
echo -ne '[                                                       ] (0%)\r';
mkdir -p ~/bin && \
curl -sSf https://just.systems/install.sh | bash -s -- --to ~/bin #> /dev/null 2>&1
echo -ne '[###########################                            ] (50%)\r';
export PATH="$PATH:$HOME/bin"
echo -ne '[#######################################################] (100%)\r\n';
