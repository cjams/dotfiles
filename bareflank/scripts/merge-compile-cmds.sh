#!/bin/bash

if [[ $# -ne 1 ]];
then
    echo "usage: $(basename $0) <build-dir>"
    exit
fi

cmds="$(find * -wholename "$1*bfintrinsics*/*compile_commands.json")"
cmds="$(find * -wholename "$1*bfvmm/*compile_commands.json") $cmds"
cmds="$(find * -wholename "$1*eapis/*compile_commands.json") $cmds"

rm -rf compile_commands.json

for cmd in "$cmds"
do
    cat $cmd >> compile_commands.json
done

sed -i 's|\]\[|,|' compile_commands.json
tac compile_commands.json | sed '/nasm/,+3d' | tac | sed '/asm/,+2d' | tee compile_commands.json
