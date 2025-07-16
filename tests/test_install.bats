#!/usr/bin/env bats

# code: language=bash

load 'helpers'

run_install() {
  run bash "scripts/install.sh"
}

@test "install script runs without errors" {
  run_install
  assert_success
}

@test "creates symlinks for core files" {
  run_install

  # Check that symlink was created and points to the correct file
  [ -L "$TEST_HOME/.bashrc" ]

  assert_equal "$(readlink "$TEST_HOME/.bashrc")" "$(pwd)/core/home/.bashrc"
}

@test "creates symlinks for module files" {
  run_install

  # Check that module symlink was created
  [ -L "$TEST_HOME/.modulefile" ]
  assert_equal "$(readlink "$TEST_HOME/.modulefile")" "$DOTFILES_DIR/modules/dummy/home/.modulefile"
}

@test "creates symlinks for directories" {
  run_install

  [ -L "$TEST_HOME/.moduledir" ]
  assert_equal "$(readlink "$TEST_HOME/.moduledir")" "$DOTFILES_DIR/modules/dummy/home/.moduledir"
}

@test "preserves existing symlinks" {
  # Create symlink pointing to different target
  ln -s "/some/other/path" "$TEST_HOME/.bashrc"

  run_install

  # Should still point to the original target
  assert_equal "$(readlink "$TEST_HOME/.bashrc")" "/some/other/path"
}

@test "preserves existing files" {
  # Create an existing file
  echo "existing content" > "$TEST_HOME/.modulefile"

  run_install

  # Should not be a symlink
  [ ! -L "$TEST_HOME/.modulefile" ]
  [ -f "$TEST_HOME/.modulefile" ]
  assert_equal "$(cat "$TEST_HOME/.modulefile")" "existing content"
}

@test "fails gracefully when ln command fails" {
  # Mock ln command to fail
  function ln() {
    return 1
  }
  export -f ln

  run_install
  # Should fail due to permission issues
  assert_failure

  # Restore original ln command
  unset -f ln
}
