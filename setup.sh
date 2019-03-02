#!/bin/bash
set -e

install_aur()
{
    if [ ! -d $1 ];
    then
        git clone https://aur.archlinux.org/$1
        pushd $1
        makepkg --syncdeps --install --noconfirm --needed
        popd
    fi
}

dir="$HOME/dotfiles"

sudo pacman -Syu --noconfirm

pkgs="bash-completion ctags git gnupg linux-headers openssh python"
pkgs="$pkgs the_silver_searcher tree ttf-inconsolata vim"
pkgs="$pkgs xdg-user-dirs zsh"

for p in $pkgs
do
    sudo pacman -S $p --needed --noconfirm
done

rm -rf $HOME/.gitconfig
rm -rf $HOME/.vim
rm -rf $HOME/.vimrc
rm -rf $HOME/.bashrc

ln -fsv $dir/gitconfig $HOME/.gitconfig
ln -fsv $dir/vim $HOME/.vim
ln -fsv $dir/vimrc $HOME/.vimrc
ln -fsv $dir/bashrc $HOME/.bashrc
ln -fsv $dir/inputrc $HOME/.inputrc

mkdir -p $HOME/{.config,.desktop,doc,dl}

xdg-user-dirs-update --set DESKTOP ~/.desktop
xdg-user-dirs-update --set MUSIC ~/.desktop
xdg-user-dirs-update --set PUBLICSHARE ~/.desktop
xdg-user-dirs-update --set TEMPLATES ~/.desktop
xdg-user-dirs-update --set VIDEOS ~/.desktop
xdg-user-dirs-update --set PICTURES ~/.desktop
xdg-user-dirs-update --set DOWNLOAD ~/dl
xdg-user-dirs-update --set DOCUMENTS ~/doc

cd $HOME/.vim
if [ ! -d bundle ];
then
    git clone https://github.com/VundleVim/Vundle.vim.git bundle/Vundle.vim
fi
vim +PluginInstall +qall

pushd $dir
git remote set-url origin git@github.com:connojd/dotfiles.git
popd

source $HOME/.bashrc
