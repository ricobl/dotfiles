# Helper functions for managing files specific to a directory
# but stored away in a central location.

[[ -z "$here_base_dir" ]] && echo 'Define a `$here_base_dir` before sourcing this module' && exit

editor="${EDITOR:-code}"

here_serialize_pwd() {
  pwd | sed "s#$HOME#HOME#" | tr / '~'
}

here_target_dir() {
  echo "$here_base_dir/$(here_serialize_pwd)"
}

here_create_file() {
  filename="$(here_target_dir)/$1"
  [[ -f "$filename" ]] && _abort "File already exists: $filename"

  content="$2"

  here_create_dir

  echo "$content" > "$filename"

  $editor "$filename"
}

here_edit_file() {
  filename="$(here_target_dir)/$1"

  $editor "$filename"
}

here_show_file() {
  filename="$(here_target_dir)/$1"

  hicat "$filename"
}

here_create_dir() {
  mkdir -p "$(here_target_dir)"
}
