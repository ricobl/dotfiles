#!/bin/bash

# Distributes files in YEAR/MONTH directories

for file in "$@"; do
    dir=`date +%Y/%m -r "$file"`
    mkdir -vp $dir
    mv -v "$file" $dir
done
