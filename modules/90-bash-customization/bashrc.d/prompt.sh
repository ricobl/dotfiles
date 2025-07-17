##################
# Code # Color   #
##################
#  00  # Off     #
#  30  # Black   #
#  31  # Red     #
#  32  # Green   #
#  33  # Yellow  #
#  34  # Blue    #
#  35  # Magenta #
#  36  # Cyan    #
#  37  # White   #
##################

# Dark colors: \[\033[0;??m\]
# Light colors: \[\033[1;??m\]

function color {
  echo "\[\033[$1;$2m\]"
}

function git_branch {
  __git_ps1 " %s"
}

function git_tag {
  tag=`git tag -l --points-at HEAD 2> /dev/null | xargs echo`
  [ -z "$tag" ] && return 1

  echo " $tag"
}

function aws_vault_session {
  # Check if AWS_VAULT is set (indicates active aws-vault session)
  if [ -n "$AWS_VAULT" ]; then
    echo " aws:$AWS_VAULT"
  fi
}

function _prompt_command () {
  local exit_code=$?

  local c_prompt=`color 0 33`
  local c_path=`color 1 33`
  local c_branch=`color 1 32`
  local c_tag=`color 1 34`
  local c_aws=`color 1 31`
  local c_off=`color 0 00`

  # Show brackets in red when the last command has failed
  if [ $exit_code != 0 ]; then
    c_prompt=`color 1 31`
  fi

  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]"
  PS1+="${c_prompt}["
  PS1+="${c_path}\W"
  PS1+="${c_branch}\$(git_branch)"
  PS1+="${c_tag}\$(git_tag)"
  PS1+="${c_aws}\$(aws_vault_session)"
  PS1+="${c_prompt}]${c_off} "
}

PROMPT_COMMAND=_prompt_command
