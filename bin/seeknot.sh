#!/bin/sh

# Program: seeknot.sh
# Version: 0.1
# Date: 2009-09-15
# Author: Enrico <rico.bl@gmail.com>
# Notes: Search for files NOT containing a text pattern.
# Usage:
# seeknot.sh "text pattern"
# seeknot.sh "file.pattern" "text pattern"

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
grep -Lr --include="$file_pattern" "$text_pattern" $path

