#!/bin/bash

script=`basename $0`

usage() {
    echo ""
    echo "Repeat a command with an interval. Hit Ctrl+C to abort."
    echo ""
    echo "Usage: "

    echo "  $script [seconds] [cmd] [arg1] [arg2] ... [argN]"
    echo ""

    exit
}

[ $# -ge 2 ] || usage

timeout="$1"

shift

while true; do
    "$@"
    sleep "$timeout"
done
