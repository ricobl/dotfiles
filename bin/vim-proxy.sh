#!/bin/bash

# Installs a wrapper for reusing the same vim instance
# and opening files in tabs.

if [ `uname` == "Darwin" ]; then
    VIM='mvim'
else
    VIM='gvim'
fi

VIM_SERVER="$VIM --servername VIM"

if [[ -z "$@" ]]; then
    if [[ `$VIM --serverlist` == "" ]]; then
        $VIM_SERVER
    else
        $VIM_SERVER --remote-send '<Esc>:tabnew<CR>'
        osascript -e 'tell application "MacVim" to activate'
    fi
else
    $VIM_SERVER --remote-tab-silent $@
fi
