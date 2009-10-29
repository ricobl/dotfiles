#!/bin/bash

# Runs a Django development server for the current project
# on the local IP address

# Exit if 'manage.py' not found
[ ! -f "./manage.py" ] && echo '	"manage.py" not found' && exit

# Get host ip and add port
host="`~/bin/myip`:8000"

# If found the "go" argument
# Wait 1 second to open the browser
[ "$1" == "--go" ] && sleep 1 && gnome-open "http://$host" &

# Run the dev server
./manage.py runserver "$host"
