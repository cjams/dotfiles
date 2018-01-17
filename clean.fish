#!/usr/bin/fish

rm -rf $HOME/.config/fish
rm -rf $HOME/.config/fisherman
rm -rf $HOME/.gitconfig
rm -rf $HOME/.vim
rm -rf $HOME/.vimrc
rm -rf $HOME/dotfiles

sudo chsh -s /bin/bash cjd
