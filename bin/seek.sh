#!/bin/sh

# Program: seek.sh
# Version: 0.1
# Date: 2009-07-23
# Author: Enrico <rico.bl@gmail.com>
# Notes: Search for files containing a text pattern.
# Usage:
# seek.sh "text pattern"
# seek.sh "file.pattern" "text pattern"

# Setup
path="./"
if [ $# -eq 1 ]; then
	file_pattern="*"
	text_pattern="$1"
elif [ $# -eq 2 ]; then
	file_pattern="$1"
	text_pattern="$2"
else
	echo "Usage: $0 [file_pattern] text_pattern"
	exit
fi

# Search for files
find $path -iname "$file_pattern" | xargs grep -sl "$text_pattern"

