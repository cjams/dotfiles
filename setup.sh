#!/bin/bash

dir="$HOME/dotfiles"

ln -sfv $dir/bashrc ~/.bashrc
ln -sfv $dir/config/fish ~/.config/fish
ln -sfv $dir/gitconfig ~/.gitconfig
ln -sfv $dir/vim ~/.vim
ln -sfv $dir/vimrc ~/.vimrc

sudo pacman -Syu --noconfirm
sudo pacman -S vim git ack fish --needed

pushd ~/.vim
git clone https://github.com/VundleVim/Vundle.vim.git bundle/Vundle.vim
popd

vim +PluginInstall +qall
