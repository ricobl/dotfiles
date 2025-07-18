#!/usr/bin/env bats

# code: language=bash

load '../helpers'

source core/dotfiles-function.sh

@test "dotfiles cd the root directory" {
  dotfiles cd
  assert_equal "$(pwd)" "$DOTFILES_ROOT"
}

@test "dotfiles cd finds a subdirectory" {
  dotfiles cd scripts
  assert_equal "$(pwd)" "$DOTFILES_ROOT/scripts"
}
