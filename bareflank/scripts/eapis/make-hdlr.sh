#!/bin/bash

#
# A helper script to initialize exit handler boilerplate
#

set -e

if [ $# -ne 2 ];
then
    echo "USAGE: make-hdlr.sh <class-name> <eapis-root>"
    exit 1
fi

lower=$1
upper=$(echo $1 | awk '{print toupper($0)}')

root=$2
inc=$root/include/hve/arch/intel_x64/exit_handler
src=$root/src/hve/arch/intel_x64/exit_handler

cp -vn $(dirname $0)/hdlr_tmpl.h $inc/$lower.h
cp -vn $(dirname $0)/hdlr_tmpl.cpp $src/$lower.cpp

sed -i "s|CLASS|$lower|g" $inc/$lower.h
sed -i "s|CLASS|$lower|g" $src/$lower.cpp

sed -i "s|ifndef "$lower"\(.*\)|ifndef "$upper"_HDLR\1|"  $inc/$lower.h
sed -i "s|define "$lower"\(.*\)|define "$upper"_HDLR\1|"  $inc/$lower.h
