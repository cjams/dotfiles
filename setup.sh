#!/bin/bash

dir="$HOME/dotfiles"

ln -sfv $dir/config/fish ~/.config/fish
ln -sfv $dir/gitconfig ~/.gitconfig
ln -sfv $dir/vim ~/.vim
ln -sfv $dir/vimrc ~/.vimrc

sudo pacman -Syu --noconfirm
sudo pacman -S ack fish git openssh vim --needed

pushd ~/.vim
git clone https://github.com/VundleVim/Vundle.vim.git bundle/Vundle.vim
vim +PluginInstall +qall
popd

sudo chsh -s $(which fish) $USER
