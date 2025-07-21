#!/usr/bin/env bash

# Identify os to load system specific scripts
os=$(uname | tr '[:upper:]' '[:lower:]')

__dotfiles_cd(){
  cd $DOTFILES_ROOT/$1
}

__dotfiles_bin(){
  # Glob pattern may expand to non-existent directories
  # and `ls` may print an error message to stderr
  ls $DOTFILES_DIR/modules/*/bin{/$os,} 2>/dev/null
}

__dotfiles_home(){
  # Glob pattern may expand to non-existent directories
  # and `ls` may print an error message to stderr
  ls -A $DOTFILES_DIR/modules/*/home{/$os,} 2>/dev/null
}

dotfiles(){
  cmd=$1
  shift

  [ -z "$cmd" ] && echo "dotfiles: missing command" && return

  func="__dotfiles_$cmd"

  [ -z "$(type -t $func)" ] && echo "dotfiles: command not found: $cmd" && return

  $func $@
}
