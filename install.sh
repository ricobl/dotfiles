#!/bin/bash

# Installs the dotfiles and helpers

# Get root
DOTFILES=`dirname $0 | xargs readlink -f`

[ ! -d ~/bin ] && ln -s "$DOTFILES/bin" ~/bin
[ ! -f ~/.bashaliases ] && ln -s "$DOTFILES/bash/.bashaliases" ~/.bashaliases
[ ! -f ~/.bashrc ] && ln -s "$DOTFILES/bash/.bashrc" ~/.bashrc
[ ! -f ~/.vimrc ] && ln -s "$DOTFILES/vim/.vimrc" ~/.vimrc
[ ! -d ~/.vim ] && ln -s "$DOTFILES/vim/.vim" ~/.vim

# Updates vim help tags
vim "+helptags ~/.vim/doc" "+q"

# Set git to use meld for diff
git config --global merge.tool meld
git config --global diff.tool meld

# Automatically track new branches
git config --global push.default tracking
git config --global branch.autosetupmerge true

# Colored output
git config --global color.ui auto

# Git aliases
git config --global alias.st status
git config --global alias.ci commit
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.lg "log --format='%Cgreen%h %Cred%cr %Creset%s %Cblue%cn'"
