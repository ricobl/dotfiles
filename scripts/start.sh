#!/bin/bash

home_dir=${1:-$HOME}

# Start a bash shell with a clean environment and preserve the HOME directory
env -i \
  HOME=$home_dir \
  TERM=$TERM \
  bash --noprofile --rcfile core/home/.bashrc
