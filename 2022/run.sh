#!/bin/bash
while [ $# -gt 0 ]; do
    case "$1" in 1)part=-1;;2)part=-2;;*) day=$1;;esac
    shift
done
cat ${day:-`date +%d`}$part.swift macros.swift | swift -
