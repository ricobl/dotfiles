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

@test "dotfiles home lists all home directories" {
  run dotfiles home
  assert_output --partial "dummy/home"
  assert_output --partial ".modulefile"
}

@test "dotfiles bin lists all bin directories" {
  run dotfiles bin
  assert_output --partial "dummy/bin"
  assert_output --partial "dummy-script"
}

@test "dotfiles bin lists OS-specific bin directories" {
  run dotfiles bin
  assert_output --partial "dummy/bin/linux"
  assert_output --partial "linux-script"
}
