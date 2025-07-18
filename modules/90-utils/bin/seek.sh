#!/bin/sh

# Program: seek
# Version: 0.1
# Date: 2009-07-23
# Author: Enrico <rico.bl@gmail.com>
# Notes: Search for files containing a text pattern.
# Usage:
# seek.sh "text pattern"
# seek.sh "file.pattern" "text pattern"

# Setup
search_dir="."
is_git_dir=`git rev-parse --git-dir 2> /dev/null || echo ''`

git_search () {
    git grep -Iil "$2" -- "*$1*"
}

grep_search () {
    grep -Iilr --exclude="*.pyc" --include="$1" "$2" "$search_dir"
}

# Configure search function
[ -z "$is_git_dir" ] && search_func=grep_search || search_func=git_search

if [ $# -eq 1 ]; then
    $search_func '*' "$1"
elif [ $# -eq 2 ]; then
    $search_func "$1" "$2"
else
	echo "Usage: $0 [file_pattern] text_pattern"
	exit
fi

