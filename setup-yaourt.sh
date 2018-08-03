#!/bin/bash
set -e

aur_install()
{
    mkdir -p $HOME/aur
    pushd $HOME/aur

    if [[ ! -d $1 ]]; then
        git clone https://aur.archlinux.org/$1.git
    fi

    cd $1
    makepkg -i -s --needed --noconfirm
    popd
}

aur_install package-query
aur_install yaourt
