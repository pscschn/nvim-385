#! /bin/zsh
#
# publishes the build as nvim config

rm -rf ~/.config/nvim
mkdir -p ~/.config/nvim/
cp -r .build/* ~/.config/nvim/