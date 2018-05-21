#!/bin/bash
set -e

short_opts="e:v:h"
long_opts="eapis-branch:,hypervisor-branch:,help"

eb=master
vb=master

reset="\e[0m"
bold_white="\e[1;99m"
bold_green="\e[1;92m"
bold_blue="\e[1;94m"
bold_red="\e[1;91m"

echo_milestone()
{
    echo -e "$bold_green==>$reset $bold_white$1$reset"
}

echo_task()
{
    echo -e " $bold_blue->$reset $bold_white$1$reset"
}

echo_usage()
{
    echo -n -e "$bold_white"
    echo -e "Usage:$reset"
    echo "  $(basename $0) [options]"
    echo ""
    echo -n -e "$bold_white"
    echo -e "Overview:$reset"
    echo "  Setup Bareflank dependencies on Arch Linux"
    echo ""
    echo -n -e "$bold_white"
    echo -e "Options:$reset"
    echo "  -e, --eapis-branch       eapis branch to clone (default: $eb)"
    echo "  -v, --hypervisor-branch  hypervisor branch to clone (default: $vb)"
    echo "  -h, --help               print this help"
    echo ""
}

echo_error()
{
    echo "ERROR: $1"
    echo_usage
    exit 1
}

#
# Verify arguments
#
options=$(getopt -o $short_opts -l $long_opts -- "$@")
if [[ $? -ne 0 ]]; then
    echo_error "Invalid options"
    echo_usage
    exit 1
fi

eval set -- "$options"
while true; do
    case "$1" in
        -e|--eapis-branch) eb="$2";;
        -v|--hypervisor-branch) vb="$2";;
        -h|--help) echo_usage && exit;;
        --) break;;
        *) echo_error "unknown option: $1";;
    esac
    shift 2
done

echo_milestone "Install dependencies"
echo_task "Update system"
sudo pacman -Syu --needed --noconfirm
echo_task "Install dependencies from official repos"
sudo pacman -S clang cmake linux-headers --needed --noconfirm
sudo pacman -S nasm ninja refind-efi --needed --noconfirm

#
# Add symlink for clang-tidy.
#
echo_milestone "Setup Bareflank development environment"
echo_task "Symlink clang-tidy"
sudo ln -fs /usr/share/clang/run-clang-tidy.py /usr/bin/run-clang-tidy-4.0.py

mkdir -p $HOME/bareflank/{build-{hypervisor,eapis},cache}
echo_task "Make build directory: $HOME/bareflank/build-hypervisor"
echo_task "Make build directory: $HOME/bareflank/build-eapis"
echo_task "Make cache directory: $HOME/bareflank/cache"
pushd $HOME/bareflank

echo_task "Symlink scripts"
cp -r $HOME/dotfiles/bareflank/scripts $HOME/bareflank/
ln -sf $HOME/dotfiles/bareflank/vimrc $HOME/bareflank/

if [ ! -d hypervisor ];
then
    echo_task "Clone $vb branch of hypervisor"
    git clone -b $vb git@github.com:connojd/hypervisor.git
fi

if [ ! -d eapis ];
then
    echo_task "Clone $eb branch of extended_apis"
    git clone -b $eb git@github.com:connojd/extended_apis.git eapis
fi

pushd hypervisor
if [ -z $(git remote | grep upstream) ];
then
    echo_task "Add upstream remote: https://github.com/bareflank/hypervisor.git"
    git remote -v add upstream https://github.com/bareflank/hypervisor.git
fi
popd

pushd eapis
if [ -z $(git remote | grep upstream) ];
then
    echo_task "Add upstream remote: https://github.com/bareflank/extended_apis.git"
    git remote -v add upstream https://github.com/bareflank/extended_apis.git
fi
popd

popd
