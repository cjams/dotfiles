#!/bin/bash

if [ $# -ne 2 ];
then
    echo "Please supply git user.email and git user.name as \$1 and \$2"
    exit
fi

sudo pacman -Syu --no-confirm
sudo pacman -S clang-tools-extra vim git ack fish --needed --no-confirm

dir=$(dirname $(readlink -f $0))

ln -s $dir/config ~/.config
ln -s $dir/vimrc ~/.vimrc
ln -s $dir/vim ~/.vim

vim +PluginInstall +qall

git config --global user.email "\"$1\""
git config --global user.name "\"$2\""
git config --global core.editor vim

git config --global alias.co 'checkout'
git config --global alias.br 'branch'
git config --global alias.ci 'commit'
git config --global alias.st 'status'
