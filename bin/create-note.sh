#!/usr/bin/env bash

title="$@"
editor="${NOTE_EDITOR:-code}"

[[ -z $title ]] && echo 'Please provide a note title' && exit 1

slugify(){
  echo "$@" | iconv -t ascii//TRANSLIT | sed -E 's/[^a-zA-Z0-9]+/-/g' | sed -E 's/^-+\|-+$//g' | tr A-Z a-z
}

slug=$(slugify "$title")
filename="_notes/$slug.md"

[[ -f $filename ]] && echo "$filename already exists. Opening..." || echo "# ${title}" > $filename

$editor $filename
