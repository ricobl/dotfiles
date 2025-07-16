#!/usr/bin/env bash

# Start bash in a slim Docker container
docker run -it --rm \
  --name dotfiles-bash \
  --mount type=bind,source="$(pwd)",target=/workspace \
  --workdir /workspace \
  --entrypoint /usr/bin/bash \
  ubuntu:latest \
  --noprofile --rcfile /workspace/core/home/.bashrc
