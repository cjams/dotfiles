#!/bin/bash

sudo pacman -S --needed --no-confirm iasl

. ./edksetup.sh
cd BaseTools && make
cd ..
build -t GCC49 -a X64 -b DEBUG -p OvmfPkg/OvmfPkgX64.dsc
