OS=`uname`

CLICOLOR=1
LSCOLORS=exgxfxDxcxDxDxCxCxHbHb
GREP_OPTIONS="--exclude=\*.svn\*"
EDITOR=vim
LANG=en_US.UTF-8
LC_CTYPE=en_US.UTF-8

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoredups
# Make some commands not show up in history
HISTIGNORE="ls:cd:cd -:pwd:exit"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# Virtualenvs
WORKON_HOME=$HOME/.virtualenvs
if [ -n "$DEFAULT_VIRTUAL_ENV" ]; then
    workon "$DEFAULT_VIRTUAL_ENV"
fi
# Pip options for virtualenv
PIP_RESPECT_VIRTUALENV=true
PIP_VIRTUALENV_BASE=$WORKON_HOME

export IPYTHON_DIR="~/.ipython"
# Enable nose rednose plugin for colored output
export NOSE_REDNOSE=1

# Add user bin to the path
[ -d "$HOME/bin" ] && PATH="$PATH:$HOME/bin"

# Change paths as required for homebrew
if [ `uname` == "Darwin" ]; then
    PATH="/usr/local/bin:/usr/local/sbin:$PATH"
fi

# Colors for Man Pages
LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
LESS_TERMCAP_me=$'\E[0m'           # end mode
LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
LESS_TERMCAP_ue=$'\E[0m'           # end underline
LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline


