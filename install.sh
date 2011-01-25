#!/bin/bash

# Installs dotfiles and helpers

# Get root
DOTFILES=`dirname $0 | xargs readlink -f`

[ ! -d ~/bin ] && ln -s "$DOTFILES/bin" ~/bin
[ ! -f ~/.bashrc ] && ln -s "$DOTFILES/dotfiles/.bashrc" ~/.bashrc
[ ! -f ~/.vimrc ] && ln -s "$DOTFILES/dotfiles/.vimrc" ~/.vimrc
[ ! -d ~/.vim ] && ln -s "$DOTFILES/dotfiles/.vim" ~/.vim

# Updates vim help tags
vim "+helptags ~/.vim/doc" "+q"

# Initialize and update submodules (for vim plugins)
git submodule init
git submodule update

# Set git user
git config --global user.name "Enrico"
git config --global user.email "rico.bl@gmail.com"

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

# Gnome Keyboard Shortcuts
set_command_shortcut(){
    gconftool-2 -t string -s "/apps/metacity/global_keybindings/run_command_$1" "$2"
    gconftool-2 -t string -s "/apps/metacity/keybinding_commands/command_$1" "$3"
}
set_gnome_shortcut(){
    gconftool-2 -t string -s "/apps/metacity/global_keybindings/$1" "$2"
}

set_command_shortcut '1' '<Mod4>v' "gvim '+cd ~'"
set_command_shortcut '2' '<Mod4>p' "gnome-terminal -e 'ipython'"

set_gnome_shortcut 'show_desktop' '<Mod4>m'

