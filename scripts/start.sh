#!/bin/bash

# Start a bash shell with a clean environment and preserve the HOME directory
env -i HOME=$HOME bash --noprofile --rcfile core/home/.bashrc
