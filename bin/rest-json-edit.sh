#!/bin/bash

URI=$1
FILENAME=`mktemp -t 'restedit'`

curl -s $URI | python -m json.tool > $FILENAME
vi $FILENAME

curl -s -X PUT $URI \
    -H "Content-Type: application/json" \
    --data-binary @$FILENAME
echo

rm $FILENAME
