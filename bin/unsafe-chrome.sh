#!/bin/bash

OS=`uname`
ARGS='--disable-web-security -–allow-file-access-from-files'

if [[ "$OS" == 'Darwin' ]]; then
    open -a "Google Chrome" --args $ARGS
else
    google-chrome $ARGS
fi

