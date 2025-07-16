#!/usr/bin/env bats

# code: language=bash

load 'helpers'

run_install_and_load() {
  local cmd="scripts/install.sh && source $HOME/.bashrc"
  [ "$#" -gt 0 ] && cmd="$cmd && $*"
  run bash -c "$cmd"
}

@test "Full dotfiles environment loads correctly" {
    # Test that the entire dotfiles environment loads without errors
    run_install_and_load
    assert_success
}

@test "Commands are available after loading environment" {
    run_install_and_load which dummy-script
    assert_line --regexp "dummy/bin/dummy-script"
}

@test "OS-specific commands are available after loading environment" {
    run_install_and_load which linux-script
    assert_line --regexp "dummy/bin/linux/linux-script"
}

@test "Performance is acceptable" {
    # Test that the environment loads in reasonable time
    local start_time
    local end_time
    local load_time

    start_time=$(date +%s.%N)
    run bash -c "source ~/.bashrc; echo 'Loaded'"
    end_time=$(date +%s.%N)

    load_time=$(echo "$end_time - $start_time" | bc -l 2>/dev/null || echo "0.1")

    # Should load in less than 1 second
    [ "$(echo "$load_time < 1.0" | bc -l 2>/dev/null || echo "1")" = "1" ]
    [ $status -eq 0 ]
    assert_line "Loaded"
}
