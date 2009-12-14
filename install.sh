#!/bin/bash

# Installs the dotfiles and helpers

# Get root
DOTFILES=`dirname $0 | xargs readlink -f`

[ ! -d ~/bin ] && ln -s "$DOTFILES/bin" ~/bin
[ ! -f ~/.bash_aliases ] && ln -s "$DOTFILES/bash/.bash_aliases" ~/.bash_aliases
[ ! -f ~/.bashrc ] && ln -s "$DOTFILES/bash/.bashrc" ~/.bashrc
[ ! -f ~/.vimrc ] && ln -s "$DOTFILES/vim/.vimrc" ~/.vimrc
[ ! -d ~/.vim ] && ln -s "$DOTFILES/vim/.vim" ~/.vim

# Updates vim help tags
vim "+helptags ~/.vim/doc" "+q"

# Set git to use meld for diff
git config --global diff.external ~/bin/git-meld.py

# Automatically track new branches
git config --global branch.autosetupmerge true

# Colored output
git config --global color.ui auto

# Git aliases
git config --global alias.st status
git config --global alias.ci commit
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.lg log "--pretty=oneline -n 10"
git config --global push.default tracking
