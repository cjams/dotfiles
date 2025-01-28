#!/bin/bash
set -e

dir="$HOME/dotfiles"

sudo apt update
sudo apt install -y zsh fontconfig fonts-powerline

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
