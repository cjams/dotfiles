#!/bin/bash
set -e

dir=$HOME/dotfiles
git clone https://github.com/connojd/dotfiles.git $dir
mkdir -pv $HOME/.config

rm -rf $HOME/.config/fish
rm -rf $HOME/.gitconfig
rm -rf $HOME/.vim
rm -rf $HOME/.vimrc

ln -sfv $dir/config/fish $HOME/.config/fish
ln -sfv $dir/gitconfig $HOME/.gitconfig
ln -sfv $dir/vim $HOME/.vim
ln -sfv $dir/vimrc $HOME/.vimrc

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
