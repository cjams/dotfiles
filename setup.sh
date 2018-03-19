#!/bin/bash
set -e

if [[ $# -ne 1 ]]; then
    echo "Usage: setup.sh <github user name>"
    exit 1
fi

ghub_user=$1

dir="$HOME/dotfiles"

rm -rf $HOME/.config/fish
rm -rf $HOME/.gitconfig
rm -rf $HOME/.vim
rm -rf $HOME/.vimrc

mkdir -pv $HOME/.config
mkdir -pv $HOME/aur

ln -fsv $dir/config/fish $HOME/.config/fish
ln -fsv $dir/gitconfig $HOME/.gitconfig
ln -fsv $dir/vim $HOME/.vim
ln -fsv $dir/vimrc $HOME/.vimrc

sudo pacman -Syu --noconfirm
sudo pacman -S python ctags fish git openssh vim tree --needed
sudo pacman -S asp the_silver_searcher ttf-inconsolata --needed
sudo pacman -S linux-headers libtraceevent perf --needed

cd $HOME/aur
if [ ! -d package-query ];
then
    git clone https://aur.archlinux.org/package-query.git
fi

if [ ! -d yaourt ];
then
    git clone https://aur.archlinux.org/yaourt.git
fi

cd $HOME/aur/package-query
makepkg -i -s --needed --noconfirm

cd $HOME/aur/yaourt
makepkg -i -s --needed --noconfirm

yaourt -S downgrade --needed --noconfirm
yaourt -S cquery-git --needed --noconfirm

cd $HOME/.vim
if [ ! -d bundle ];
then
    git clone https://github.com/VundleVim/Vundle.vim.git bundle/Vundle.vim
fi
vim +PluginInstall +qall

cd $HOME/.vim/bundle/LeaderF
./install.sh

cd $HOME
if [ ! -e $HOME/.ssh/id_rsa.pub ]; then
	ssh-keygen
	git clone https://github.com/b4b4r07/ssh-keyreg.git
	./ssh-keyreg/bin/ssh-keyreg -u $ghub_user github
        rm -rf ssh-keyreg
fi

sudo cp -v $dir/linux/perf.conf /etc/sysctl.d/perf.conf
sudo sysctl -p /etc/sysctl.d/perf.conf

sudo chsh -s $(which fish) $USER
fish -c $dir/setup.fish
