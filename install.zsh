#! /bin/zsh

S=$(dirname "${BASH_SOURCE[0]}")

# install tpm
source $S/scripts/install-tpm.zsh

# backup nvim
#source ./$S/scripts/backup-nvim.zsh

# backup tmux
#source ./$S/scripts/backup-tmux.zsh

# configure nvim
source $S/scripts/configure-nvim.zsh

# configure tmux
source $S/scripts/configure-tmux.zsh