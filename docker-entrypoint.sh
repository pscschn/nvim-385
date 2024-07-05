#! /bin/bash 

tmux source-file ~/.tmux.conf
. ~/.tmux/plugins/tpm/bin/install_plugins

tail -f /dev/null