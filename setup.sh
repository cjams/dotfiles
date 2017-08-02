#!/bin/bash

if [ $# -ne 2 ];
then
    echo "Please supply git user.email and git user.name as \$1 and \$2"
    exit
fi

if [ ! -e /usr/bin/nvim ];
then
    echo "Please install neovim and then try again"
    exit
fi

cp -v ~/dotfiles/git-prompt.sh ~/.git-prompt.sh
cp -v ~/dotfiles/git-completion.bash ~/.git-completion.bash
cp -v ~/dotfiles/.bashrc ~/.bashrc

mkdir -v -p ~/.config/nvim/colors
cp -v ~/dofiles/lettuce.vim ~/.config/nvim/colors/lettuce.vim
cp -v ~/dotfiles/.vimrc ~/.config/nvim/init.vim

source ~/.bashrc

git config --global user.email "\"$1\""
git config --global user.name "\"$2\""
git config --global core.editor nvim
