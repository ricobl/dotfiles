#!/bin/sh

# Notes: Recursively search for files following pattern.
# Usage:
# find-file.sh "glob pattern"
# find-file.sh "glob pattern" /path

# Setup
glob=`echo "$1" | sed 's/\*/.+/g'`
path="$2"
[ -z $path ] && path="."

if [ $# -eq 0 ]; then
	echo "Usage: $0 glob_pattern [path]"
	return 2
fi

# Search for files or return with no error
ack -afg $glob "$path" || exit 0
