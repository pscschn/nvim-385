#! /bin/zsh 

echo 'Installing ripgrep...'
sudo -S dnf -y install ripgrep

echo 'Checking for neovim dir..' 
if [ -d ~/.config/nvim ]; then 
    echo 'Backing up existing nvim config...' 
    mv ~/.config/nvim  ~/.config/nvim.bck
else
    mkdir -p ~/.config/nvim 
fi


echo 'Checking for tmux dir..' 
if [ -d ~/.config/tmux ]; then 
    echo 'Backing up existing tmux config...' 
    mv ~/.config/tmux ~/.config/tmux.bck
else 
    mkdir -p ~/.config/tmux
fi

echo 'Copying nvim config...'
rm -rf ~/.config/nvim
cp -fr ./nvim ~/.config/nvim

echo 'Copying tmux config...'
cp -fr ./tmux/.tmux.conf ~/

echo 'Checking if tpm exists...'
TPM_PATH=~/.tmux/plugins/tpm

if [ ! -d $TPM_PATH ]; then 
echo 'Installing tmux plugin manager...'
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    echo 'Tpm seems to be already installed' 
fi 
