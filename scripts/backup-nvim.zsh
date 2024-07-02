#! /bin/zsh 

# backup nvim config directory

NVIM_PATH=~/.config/nvim
TIMESTAMP=$(date '+%Y%m%d%H%M%S')

echo 'Checking for tmux dir..' 
if [ -d $NVIM_PATH ]; then 
    echo 'Backing up existing tmux config...' 
    mv $NVIM_PATH $NVIM_PATH.$TIMESTAMP.bck
else 
    mkdir -p $NVIM_PATH
fi
