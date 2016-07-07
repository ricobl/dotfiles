#!/bin/bash

# Distributes files in YEAR/MONTH directories

OS=`uname`

timestamp_osx () {
    file="$1"
    echo `stat -f '%Sm' -t '%Y/%m' "$file"`
}

timestamp_nix () {
    file="$1"
    echo `date +%Y/%m -r "$file"`
}

if [[ $OS == 'Darwin' ]]; then
    timestamp=timestamp_osx
else
    timestamp=timestamp_nix
fi

for file in "$@"; do
    dir=`"$timestamp" "$file"`
    echo mkdir -vp $dir
    echo mv -v "$file" "$dir"
done
