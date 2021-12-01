#!/bin/bash

TARGET='main'
IFLAGS='-Iadvent-of-code-api-0.2.8.1/src'
CFLAGS='-O2'
LFLAGS='-threaded -rtsopts'

[ $# -lt 1 ] && echo "argument required" && exit
[ ! -e "$1" ] && echo "file not found" && exit
[ "$1" -nt "run" ] || (echo "up to date" && exit)

function run {
    echo $*
    ($*) || exit
}

run ghc $CFLAGS $IFLAGS --make "$1" -o "$TARGET" $LFLAGS
run ./"$TARGET"
