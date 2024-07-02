#! /bin/zsh 

# Existing tmux config will be 
# overwritten without separate backup
echo 'Copying tmux config...'
cp -fr ./tmux/.tmux.conf ~/

# Reload Tmux configuration and install plugins
tmux new-session -d -s install-plugins \
    'sleep 1; tmux source-file ~/.tmux.conf; ~/.tmux/plugins/tpm/bin/install_plugins; tmux kill-session -t install-plugins'

tmux source-file ~/.tmux.conf
