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

if [[ $# -ne 1 ]]; then
    echo "Usage: setup.sh <github user name>"
    exit 1
fi

ghub_user=$1
dir="$HOME/dotfiles"

sudo pacman -Syu --noconfirm
sudo pacman -S linux-headers gnupg ttf-inconsolata --needed --noconfirm
sudo pacman -S python ctags git openssh vim tree --needed --noconfirm
sudo pacman -S the_silver_searcher --needed --noconfirm
sudo pacman -S radare2 xdg-user-dirs --needed --noconfirm

rm -rf $HOME/.gitconfig
rm -rf $HOME/.vim
rm -rf $HOME/.vimrc
rm -rf $HOME/.bashrc

mkdir -pv $HOME/aur
pushd $HOME/aur
install_aur yaourt
install_aur uefi-shell-git
popd

if [ ! -d $HOME/.gnupg ];
then
    gpg --generate-key
fi

ln -fsv $dir/gitconfig $HOME/.gitconfig
ln -fsv $dir/vim $HOME/.vim
ln -fsv $dir/vimrc $HOME/.vimrc
ln -fsv $dir/gpg.conf $HOME/.gnupg/gpg.conf
ln -fsv $dir/bashrc $HOME/.bashrc
ln -fsv $dir/inputrc $HOME/.inputrc

mkdir -p $HOME/{.config,.desktop,docs,downloads}

echo 'XDG_DESKTOP_DIR=$HOME/.desktop' > $HOME/.config/user-dirs.dirs
echo 'XDG_PUBLICSHARE_DIR=$HOME/.desktop' >> $HOME/.config/user-dirs.dirs
echo 'XDG_TEMPLATES_DIR=$HOME/.desktop' >> $HOME/.config/user-dirs.dirs
echo 'XDG_MUSIC_DIR=$HOME/.desktop' >> $HOME/.config/user-dirs.dirs
echo 'XDG_PICTURES_DIR=$HOME/.desktop' >> $HOME/.config/user-dirs.dirs
echo 'XDG_VIDEO_DIR=$HOME/.desktop' >> $HOME/.config/user-dirs.dirs
echo 'XDG_DOCUMENTS_DIR=$HOME/docs' >> $HOME/.config/user-dirs.dirs
echo 'XDG_DOWNLOADS_DIR=$HOME/downloads' >> $HOME/.config/user-dirs.dirs

cd $HOME/.vim
if [ ! -d bundle ];
then
    git clone https://github.com/VundleVim/Vundle.vim.git bundle/Vundle.vim
fi
vim +PluginInstall +qall

$HOME/dotfiles/bareflank/setup-arch.sh
$HOME/dotfiles/setup-cquery.sh

pushd $dir
git remote set-url origin git@github.com:connojd/dotfiles.git
popd

source $HOME/.bashrc
