#!/bin/bash

dir="$HOME/dotfiles"

ln -sfv $dir/config/fish ~/.config/fish
ln -sfv $dir/gitconfig ~/.gitconfig
ln -sfv $dir/vim ~/.vim
ln -sfv $dir/vimrc ~/.vimrc

sudo pacman -Syu --noconfirm
sudo pacman -S python ctags fish git openssh vim --needed
sudo pacman -S the_silver_searcher --needed

pushd ~/.vim
git clone https://github.com/VundleVim/Vundle.vim.git bundle/Vundle.vim
vim +PluginInstall +qall

pushd bundle/LeaderF
./install.sh

popd
popd

sudo chsh -s $(which fish) $USER

fish -c ./setup.fish
