#!/bin/bash
set -e

dir="$HOME/dotfiles"

sudo apt update
sudo apt install -y zsh fontconfig tmux vim tree gnome-keyring neovim
sudo apt install -y python-is-python3 python3-pip python3-venv

# Setup vimage
cp -v $dir/vimrc $HOME/.vimrc

if [ ! -d $HOME/.vim/bundle ];
then
    mkdir -p $HOME/.vim
    cd $HOME/.vim
    git clone https://github.com/VundleVim/Vundle.vim.git bundle/Vundle.vim
    vim +PluginInstall +qall
fi

cd $HOME

ZSH_BASE="$HOME/.oh-my-zsh"
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

if [ ! -d "$ZSH_BASE" ];
then
    # Get oh-my-zsh
    wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh
    sh install.sh --unattended

    git clone --depth=1 https://github.com/softmoth/zsh-vim-mode $ZSH_CUSTOM/plugins/zsh-vim-mode
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
    git clone --depth=1 https://github.com/zsh-users/zsh-completions $ZSH_CUSTOM/plugins/zsh-completions
    git clone --depth=1 https://github.com/romkatv/powerlevel10k $ZSH_CUSTOM/themes/powerlevel10k

    # Link custom zsh bits
    ln -fsv $dir/oh-my-zsh/custom/alias.zsh $ZSH_CUSTOM/alias.zsh
    ln -fsv $dir/oh-my-zsh/custom/bindkey.zsh $ZSH_CUSTOM/bindkey.zsh

    cp -v $dir/zshrc $HOME/.zshrc
    cp -v $dir/p10k.zsh $HOME/.p10k.zsh
fi

# vscode
cd $HOME/Downloads
wget -O vscode.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
sudo dpkg -i vscode.deb

# fonts
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts
cd nerd-fonts
./install.sh SourceCodePro
./install.sh Meslo

# tmux
cp $HOME/dotfiles/tmux.conf $HOME/.tmux.conf

# nvim
cd $HOME/Downloads
wget -O https://github.com/neovim/neovim/releases/download/v0.10.3/nvim-linux64.tar.gz
tar xvf nvim-linux64.tar.gz
sudo mkdir -p /usr/local/bin
sudo cp -v nvim-linux64/bin/nvim /usr/local/bin
mkdir -p $HOME/.config/nvim/lua/user
cp -v $HOME/dotfiles/init.lua $HOME/.config/nvim/init.lua
cp -v $HOME/dotfiles/vscode_keymaps.lua $HOME/.config/nvim/lua/user/
