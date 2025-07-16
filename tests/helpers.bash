#!/usr/bin/env bats

# Setup function that runs before each test
setup() {
    bats_load_library bats-support
    bats_load_library bats-assert

    # Set up test environment
    export TEST_DIR="$(mktemp -d)"
    export DOTFILES_DIR="$(pwd)/tests"

    # Create a temporary home directory for testing
    export TEST_HOME="$TEST_DIR/home"
    mkdir -p "$TEST_HOME"

    # Backup original environment variables
    export ORIGINAL_HOME="$HOME"
    export ORIGINAL_PATH="$PATH"

    # Set test environment
    export HOME="$TEST_HOME"
}

# Teardown function that runs after each test
teardown() {
    # Restore original environment
    export HOME="$ORIGINAL_HOME"
    export PATH="$ORIGINAL_PATH"

    # Clean up test directory
    rm -rf "$TEST_DIR"
}
