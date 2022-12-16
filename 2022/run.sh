#!/bin/bash
LIB=""
while [ $# -gt 0 ]; do
    case "$1" in 1)part=-1;;2)part=-2;;-l*)LIB="$LIB ${1#-l}";;*) day=$1;;esac
    shift
done
cat ${day:-`date +%d`}$part.swift macros.swift $LIB | swift -
