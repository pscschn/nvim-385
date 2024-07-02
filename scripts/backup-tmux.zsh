#! /bin/zsh 

# backup tmux config directory

TMUX_PATH=~/.config/tmux
TIMESTAMP=$(date '+%Y%m%d%H%M%S')

echo 'Checking for tmux dir..' 
if [ -d $TMUX_PATH ]; then 
    echo 'Backing up existing tmux config...' 
    mv $TMUX_PATH $TMUX_PATH.$TIMESTAMP.bck
else 
    mkdir -p $TMUX_PATH
fi
