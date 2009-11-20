#!/bin/bash

# Installs the dotfiles and helpers

[ ! -d ~/bin ] && ln -s ~/dotfiles/bin ~/bin
[ ! -f ~/.bash_aliases ] && ln -s ~/dotfiles/bash/.bash_aliases ~/.bash_aliases
[ ! -f ~/.bashrc ] && ln -s ~/dotfiles/bash/.bashrc ~/.bashrc
[ ! -f ~/.vimrc ] && ln -s ~/dotfiles/vim/.vimrc ~/.vimrc
[ ! -d ~/.vim ] && ln -s ~/dotfiles/vim/.vim ~/.vim

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
git config --global alias.lg log --pretty=oneline -n 10
