#!/bin/bash
set -e

sudo pacman -Syu --needed --noconfirm
sudo pacman -S clang cmake linux-headers nasm ninja --needed --noconfirm

mkdir -vp $HOME/bareflank/build
pushd $HOME/bareflank

git clone -b dev git@github.com:connojd/hypervisor.git
pushd hypervisor

git remote -v add upstream https://github.com/bareflank/hypervisor.git

popd
popd
