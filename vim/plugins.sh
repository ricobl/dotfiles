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

# Install snipmate_for_django
git clone git://github.com/ricobl/snipmate_for_django.git
# Copy snippets
cp -rfu snipmate_for_django/snippets/*.snippets ~/.vim/snippets
# Cleanup
rm -rf snipmate_for_django

# Copy bufkill plugin to vim directory
cp .vim/plugin/bufkill.vim ~/.vim/plugin
