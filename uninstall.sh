#!/bin/bash

# Uninstalls dotfiles

# Get root
DOTFILES=`dirname $0 | xargs readlink -f`

rm ~/bin
rm ~/.bashaliases
rm ~/.bashrc
rm ~/.vimrc
rm ~/.vim
