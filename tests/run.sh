#!/usr/bin/env bash

ARGS=(
  --recursive
  --line-reference-format colon
)

if [ "$#" -eq 0 ]; then
  ARGS+=("tests/")
fi

bats "${ARGS[@]}" "$@"
