#!/bin/bash

_complete_options() {
  local cur="$1"

  # Parse options from the script
  local _options=$(cat `which here` | grep -E '\--[a-z-]+' | sed -E 's/^.*(--[a-z-]+).*$/\1/')
  compgen -W "${_options[*]}" -- "${cur}"
}

_complete_commands() {
  local cur="$1"
  local bin_dir=$(here --dir)

  # Switch to directory for this path and use file completion from there to get commands
  [[ -d $bin_dir ]] && cd "$bin_dir" && compgen -f -- "${cur}"
}

# In old bash versions it's impossible to customize the suffix for `compgen` suggestions.
# The only way is to selectively append slashes to directories and spaces to everything else.
# This is done by editing the COMPREPLY global array in-place.

_append_spaces_to_replies() {
  local i=0
  for ((i=0; i<${#COMPREPLY[@]}; i++)); do
    COMPREPLY[$i]="${COMPREPLY[$i]} "
  done
}

_append_slashes_to_directories() {
  local i=0
  for ((i=0; i<${#COMPREPLY[@]}; i++)); do
    if [[ -d "${COMPREPLY[$i]}" ]]; then
      COMPREPLY[$i]="${COMPREPLY[$i]}/"
    fi
  done
}

_here_completion() {
  local cur="$2"
  local num_words=${#COMP_WORDS[@]}
  local current_word_index=$COMP_CWORD

  local first_word=${COMP_WORDS[1]}

  # `$ here <tab>`
  # Complete options or commands when on the first item
  if [[ $current_word_index == 1 ]]; then
    # Combine commands and options and let them get filtered by current word
    COMPREPLY=( $(_complete_commands "$cur") $(_complete_options "$cur") )
    _append_spaces_to_replies

  # `$ here --edit <tab>`
  # `$ here --show <tab>`
  # Complete commands after the `--edit` or `--show` params
  elif [[ $current_word_index == 2 && "$first_word" =~ ^--(edit|show)$ ]]; then
    COMPREPLY=( $(_complete_commands "$cur") )
    _append_spaces_to_replies

  # `$ here --<param> <tab>`
  # Don't complete after other params
  elif [[ $current_word_index == 2 && "$first_word" == "--"* ]]; then
    COMPREPLY=()

  # `$ here --edit <command> <tab>`
  # Don't complete after `--edit <command>`
  elif [[ $current_word_index == 3 && "$first_word" == "--edit" ]]; then
    COMPREPLY=()

  # `$ here <command> <tab> ... <tab-n>`
  # Fallback to file completion
  else
    COMPREPLY=( $(compgen -f -- "${cur}") )
    _append_slashes_to_directories
  fi
}

# Using nospace to prevent spaces on directories
complete -o nospace -F _here_completion here
