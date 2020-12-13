#!/bin/bash
set -e

sudo apt install tree vim zsh

pkgs="tree vim zsh silversearcher-ag"

sudo apt install -y $pkgs

rm -rf $HOME/.gitconfig
rm -rf $HOME/.vim
rm -rf $HOME/.vimrc
rm -rf $HOME/.bashrc
rm -rf $HOME/.inputrc

dir="$HOME/dotfiles"

ln -fsv $dir/gitconfig $HOME/.gitconfig
ln -fsv $dir/vim $HOME/.vim
ln -fsv $dir/vimrc $HOME/.vimrc
ln -fsv $dir/bashrc $HOME/.bashrc
ln -fsv $dir/inputrc $HOME/.inputrc

cd $HOME/.vim
if [ ! -d bundle ];
then
    git clone https://github.com/VundleVim/Vundle.vim.git bundle/Vundle.vim
fi

vim +PluginInstall +qall
