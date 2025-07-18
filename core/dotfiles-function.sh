#!/usr/bin/env bash

__dotfiles_cd(){
  cd $DOTFILES_ROOT/$1
}

dotfiles(){
  cmd=$1
  shift

  [ -z "$cmd" ] && echo "dotfiles: missing command" && return

  func="__dotfiles_$cmd"

  [ -z "$(type -t $func)" ] && echo "dotfiles: command not found: $cmd" && return

  $func $@
}
