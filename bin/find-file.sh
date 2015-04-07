#!/bin/sh

# Notes: Recursively search for files following pattern.
# Usage:
# find-file.sh "glob pattern"
# find-file.sh "glob pattern" /path

# Setup
glob="*$1*"
path="$2"
[ -z $path ] && path="."

if [ $# -eq 0 ]; then
	echo "Usage: $0 glob_pattern [path]"
	exit 2
fi

# Search for files or return with no error
find "$path" -iwholename "$glob" || exit 0
