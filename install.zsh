#! /bin/zsh 

# echo 'Installing ripgrep...'
#sudo -S dnf -y install ripgrep

# backup nvim
source ./scripts/backup-nvim.zsh

# backup tmux
source ./scripts/backup-tmux.zsh

# configure nvim
source ./scripts/configure-nvim.zsh

# configure tmux
source ./scripts/configure-tmux.zsh

# install tpm
source ./scripts/install-tpm.zsh