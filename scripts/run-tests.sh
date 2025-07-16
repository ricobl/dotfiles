#!/usr/bin/env bash

docker run -it --rm \
  --name dotfiles-bats \
  --mount type=bind,source="$(pwd)",target=/workspace \
  --workdir /workspace \
  --entrypoint tests/run.sh \
  bats/bats:latest \
  "$@"
