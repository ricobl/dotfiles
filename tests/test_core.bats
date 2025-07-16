#!/usr/bin/env bats

# code: language=bash

load 'helpers'


load_dotfiles() {
    source "core/home/.bashrc"
}

@test "Resolves the project root from the .bashrc symlink" {
    load_dotfiles
    [ -n "$DOTFILES_ROOT" ]
    [ -d "$DOTFILES_ROOT" ]
    assert_equal "$DOTFILES_ROOT" "$(pwd)"
}

@test "Core bashrc loads without errors" {
    run load_dotfiles
    assert_success
}

@test "Module bin directory is added to PATH" {
    load_dotfiles
    assert_regex "$PATH" "modules/dummy/bin"
}

@test "OS-specific module bin directory is added to PATH" {
    load_dotfiles
    assert_regex "$PATH" "modules/dummy/bin/linux"
}

@test "OS-specific modules are loaded" {
    run load_dotfiles
    assert_line "dummy bashrc linux"
}
