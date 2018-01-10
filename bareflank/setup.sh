#!/bin/bash

sudo pacman -Syu --needed --noconfirm
sudo pacman -S clang cmake linux-headers nasm ninja --needed --noconfirm

mkdir -p $HOME/bareflank/build
pushd $HOME/bareflank

git clone -b dev https://github.com/connojd/hypervisor.git
pushd hypervisor

git remote add upstream https://github.com/bareflank/hypervisor.git
git remote add zepf https://github.com/jwzepf/hypervisor.git
git remote add wright https://github.com/jaredwright/hypervisor.git
git remote add quinn https://github.com/rianquinn/hypervisor.git

popd
popd
