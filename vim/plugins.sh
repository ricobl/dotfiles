#!/bin/bash

# Go to .vim user directory
cd ~/.vim

# Clone the git repo and remove git control files and helpers
git clone git://github.com/msanders/snipmate.vim.git snipmate
rm -rf snipmate/.git
rm -f snipmate/convertSnip.py
# Remove snipmate's snippets so they don't overwrite existent ones
rm -rf snipmate/snippets

# Copies new files recursively
cp -rfu snipmate/* ./

# Cleanup the clone dir
rm -rf snipmate

# Updates vim help tags
vim "+helptags ~/.vim/doc" "+q"

