#!/bin/bash

##################
# Code # Color   #
##################
#  00  # Off     #
#  30  # Black   #
#  31  # Red     #
#  32  # Green   #
#  33  # Yellow  #
#  34  # Blue    #
#  35  # Magenta #
#  36  # Cyan    #
#  37  # White   #
##################

function color {
    echo "\033[$1;$2m"
}

c_dir=`color 1 34`
c_off=`color 0 00`

for repo in `find -type d -name ".git"`
do
    pushd "$repo/.." > /dev/null
        echo -e "${c_dir}`pwd`${c_off}"
        git $*
    popd > /dev/null
done

