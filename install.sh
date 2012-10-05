#!/bin/bash

# Installs dotfiles and helpers

realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

# Get root
SCRIPT_PATH=`realpath $0`
DOTFILES=`dirname $SCRIPT_PATH`

[ ! -d ~/bin ] && ln -s "$DOTFILES/bin" ~/bin
[ ! -f ~/.profile ] && ln -s "$DOTFILES/dotfiles/.profile" ~/.profile
[ ! -f ~/.bashrc ] && ln -s "$DOTFILES/dotfiles/.bashrc" ~/.bashrc
[ ! -f ~/.bash_profile ] && ln -s "$DOTFILES/dotfiles/.bash_profile" ~/.bash_profile
[ ! -f ~/.inputrc ] && ln -s "$DOTFILES/dotfiles/.inputrc" ~/.inputrc
[ ! -f ~/.vimrc ] && ln -s "$DOTFILES/dotfiles/.vimrc" ~/.vimrc
[ ! -d ~/.ipython ] && ln -s "$DOTFILES/dotfiles/.ipython" ~/.ipython
[ ! -d ~/.vim ] && ln -s "$DOTFILES/dotfiles/.vim" ~/.vim

# Updates vim help tags
#vim "+helptags ~/.vim/doc" "+q"

# Initialize and update submodules (for vim plugins)
git submodule init
git submodule update


[ -z 'git config --global user.name' ] && git config --global user.name "Petry"
[ -z 'git config --global user.email' ] && git config --global user.email "marcos.petry@corp.globo.com"

# Configure diff / merge tool
if [ `uname` == "Darwin" ]; then
    git config --global merge.tool opendiff
    git config --global diff.tool opendiff
else
    git config --global merge.tool meld
    git config --global diff.tool meld
fi
# Disable ".orig" backups
git config --global mergetool.keepBackup false

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
git config --global alias.lg "log --format='%Cgreen%h %Cred%cr %Creset%s %Cblue%cn%Cgreen%d'"
