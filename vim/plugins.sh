#!/bin/bash

# Installs snipmate
git clone git://github.com/msanders/snipmate.vim.git snipmate
rm -rf snipmate/.git
mv -uf snipmate/* .vim/
#rm -rf snipmate
