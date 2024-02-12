OS=`uname`

HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoreboth
# Make some commands not show up in history
HISTIGNORE="ls:cd:cd -:pwd:exit"

# Append to the history file, don't overwrite it
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s histappend checkwinsize

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

function _prompt_command () {
  local exit_code=$?

  local c_prompt=`color 0 33`
  local c_path=`color 1 33`
  local c_branch=`color 1 32`
  local c_tag=`color 1 34`
  local c_off=`color 0 00`

  # Show brackets in red when the last command has failed
  if [ $exit_code -gt 0 ]; then
    local c_prompt=`color 1 31`
  fi

  PS1="${c_prompt}[${c_path}\W$c_branch\$(git_branch)$c_tag\$(git_tag)${c_prompt}]${c_off} "
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
}

PROMPT_COMMAND='_prompt_command'

# Colors for Man Pages
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

if [ $OS == "Darwin" ]; then
  alias ls='ls -G'
  # Change paths as required for homebrew
  PATH="/usr/local/bin:/usr/local/sbin:$PATH"
  # Disable analytics on homebrew
  export HOMEBREW_NO_ANALYTICS=1
else
  alias ls='ls --color=auto'
  # Same as Mac's open
  alias open='gnome-open 2> /dev/null'
fi

# EASY FILE FIND
# Disable glob expansion for find-file (ff) and seek
# http://blog.edwards-research.com/2011/05/preventing-globbing/
__ff(){ ~/bin/find-file.sh "$@"; set +f; }
__seek(){ ~/bin/seek.sh "$@"; set +f; }

alias ff='set -f; __ff'
alias seek='set -f; __seek'
alias xvim="xargs vim; set +f"
alias xcode="xargs code"
alias ll="ls -l"
# Faster and better grep options
alias grep="grep --color=auto --exclude=*.pyc -I"

# Add user bin to the path
[ -d  "$HOME/bin" ] && PATH="$PATH:$HOME/bin"

# Add work directory to CDPATH path
[ -d  "$HOME/work" ] && CDPATH="$CDPATH:$HOME/work"

# Enable bash completion if available
if [ $OS == "Darwin" ]; then
  _etc_completion=`brew --prefix`/etc/bash_completion
else
  _etc_completion='/etc/bash_completion'
fi

[[ -f $_etc_completion ]] && . $_etc_completion

# Hide *.pyc from bash filename completion
export FIGNORE='pyc'

# # Custom completions
. ~/bin/cddotfiles_bash_completion
. ~/bin/here_bash_completion

export IPYTHONDIR="~/.ipython"
export PYTHONDONTWRITEBYTECODE=1

# Enable links with Delta / git diff
export DELTA_PAGER='less -rX'

pycd(){
  local filename="`python -c "import pkgutil;print pkgutil.get_loader('$1').filename"`"
  cd $(dirname "$filename")
}

cdgit(){
  cd "$(git rev-parse --show-toplevel)/$1"
}
cddotfiles(){
  local bashrc=$(readlink ~/.bashrc)
  local dotfiles=$(dirname $(dirname $bashrc))
  cd "$dotfiles"/$1
}

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export FZF_DEFAULT_OPTS="--bind ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
