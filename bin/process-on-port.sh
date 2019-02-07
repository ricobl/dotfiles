#!/bin/bash

# Shows which process is running on a specific port

lsof -i :$1
