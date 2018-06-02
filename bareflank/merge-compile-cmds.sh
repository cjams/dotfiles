#!/bin/bash

if [[ $# -ne 1 ]];
then
    echo "usage: $(basename $0) <build-dir>"
    exit
fi

rm -rf compile_commands.json
cmd_files=$(find . -name compile_commands.json)
sed -e '1s/^/[\n/' -e '$s/,$/\n]/' $cmd_files > compile_commands.json
