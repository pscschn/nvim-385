#! /bin/zsh
#
# Installs just which is just a command runner

set -eu;
echo "Installing just...";
echo -ne '                          (0%)\r';
wget -q https://github.com/casey/just/releases/download/${JUST_VER}/just-${JUST_VER}-x86_64-unknown-linux-musl.tar.gz;
echo -ne '#####                     (25%)\r';
mkdir just-${JUST_VER}-x86_64-unknown-linux-musl;
tar --no-same-owner --no-same-permissions -xf just-${JUST_VER}-x86_64-unknown-linux-musl.tar.gz -C just-${JUST_VER}-x86_64-unknown-linux-musl;
echo -ne '#############             (50%)\r';
cp -r just-${JUST_VER}-x86_64-unknown-linux-musl /usr/local/src/just-${JUST_VER}-x86_64;
echo -ne '##################        (75%)\r';
ln -s /usr/local/src/just-${JUST_VER}-x86_64/just /usr/bin/just;
rm -rf just-*;
echo -ne '#######################   (100%)\r';