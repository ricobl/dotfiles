#!/bin/bash

# Check whether duti is installed
if ! command -v duti &> /dev/null; then
  echo "duti could not be found. Install with 'brew install duti'"
  exit 1
fi

# Get the editor id based on the app name
app_name="${1:-Cursor}"
editor_id=$(osascript -e "id of app \"$app_name\"")

curl "https://raw.githubusercontent.com/github/linguist/master/lib/linguist/languages.yml" \
  | yq -r "to_entries | (map(.value.extensions) | flatten) - [null] | unique | .[]"  \
  | xargs -L 1 -I "{}" duti -s ${editor_id} {} all
