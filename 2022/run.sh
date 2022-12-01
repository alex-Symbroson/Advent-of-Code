day=`date +%d`
cat ${1:-$day}.swift macros.swift | swift -
