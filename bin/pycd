#!/bin/bash

# Program: pycd
# Version: 0.1
# Date: 2011-03-20
# Author: Enrico <rico.bl@gmail.com>
# Notes: Changes the current directory based on a python module.
# alias pycd='. ~/bin/pycd'
# Usages:
#   . ~/bin/pycd os
#   . ~/bin/pycd django.contrib.admin

# Setup
module="$1"
[ -z $module ] && exit

path=`python -c "import $1; print $1.__file__" | xargs dirname`

cd "$path"

