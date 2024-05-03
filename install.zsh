#! /bin/zsh 

echo 'Installing ripgrep...'
sudo -S dnf -y install ripgrep

echo 'Backing up existing nvim config...' 
mv ~/.config/nvim  ~/.config/nvim.bck

echo 'Backing up existing tmux config...' 
mv ~/.config/tmux ~/.config/tmux.bck

echo 'Copying nvim config...'
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
