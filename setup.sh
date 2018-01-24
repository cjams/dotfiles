#!/bin/bash
set -e

dir="$HOME/dotfiles"

rm -rf $HOME/.config/fish
rm -rf $HOME/.gitconfig
rm -rf $HOME/.vim
rm -rf $HOME/.vimrc

mkdir -pv $HOME/.config

ln -sfv $dir/config/fish $HOME/.config/fish
ln -sfv $dir/gitconfig $HOME/.gitconfig
ln -sfv $dir/vim $HOME/.vim
ln -sfv $dir/vimrc $HOME/.vimrc

sudo pacman -Syu --noconfirm
sudo pacman -S python ctags fish git openssh vim --needed
sudo pacman -S asp the_silver_searcher --needed
sudo pacman -S linux-headers linux-tools --needed

pushd $HOME/.vim
git clone https://github.com/VundleVim/Vundle.vim.git bundle/Vundle.vim
vim +PluginInstall +qall

pushd bundle/LeaderF
./install.sh

popd
popd

sudo cp -v $dir/linux/perf.conf /etc/sysctl.d/perf.conf
sudo sysctl -p /etc/sysctl.d/perf.conf

sudo chsh -s $(which fish) $USER
fish -c $dir/setup.fish
