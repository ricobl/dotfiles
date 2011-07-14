# Based on Ubuntu's /etc/skel/.bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm|xterm-color) color_prompt=yes;;
esac

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

c_prompt=`color 0 33`
c_path=`color 1 33`
c_branch=`color 1 32`
c_tag=`color 1 34`
c_off=`color 0 00`

function git_branch {
    __git_ps1 " %s"
}

function git_tag {
    tag=`git describe --exact-match --tags HEAD 2> /dev/null`
    [ -z "$tag" ] && return 1

    echo " $tag"
}

PS1="${c_prompt}[${c_path}\W$c_branch\$(git_branch)$c_tag\$(git_tag)${c_prompt}]${c_off} "

unset color_prompt force_color_prompt
unset c_prompt c_path c_branch c_tag c_off

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

if [ `uname` == "Darwin" ]; then
    alias ls='ls -G'
else
    alias ls='ls --color=auto'
fi
alias grep='grep --color=auto'

# Colors for Man Pages
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
	# Load fabfile completion
    . ~/bin/fab_bash_completion
    . ~/bin/vagrant_bash_completion

    # Enable pip completion
    [[ -n `which pip` ]] && eval "`pip completion --bash`"
fi

# Change paths as required for homebrew
if [ `uname` == "Darwin" ]; then
    PATH="/usr/local/bin:/usr/local/sbin:$PATH"
fi

# Add user bin to the path
[ -d  "$HOME/bin" ] && PATH="$PATH:$HOME/bin"
# Add user opt bin to the path
[ -d  "$HOME/opt/bin" ] && PATH="$PATH:$HOME/opt/bin"

# Virtualenvs
if [[ -f '/usr/local/bin/virtualenvwrapper.sh' ]]; then
    export WORKON_HOME="$HOME/.virtualenvs"
    source "/usr/local/bin/virtualenvwrapper.sh"

    if [ -n "$DEFAULT_VIRTUAL_ENV" ]; then
        workon "$DEFAULT_VIRTUAL_ENV"
    fi
    # Pip options for virtualenv
    export PIP_RESPECT_VIRTUALENV=true
    export PIP_VIRTUALENV_BASE=$WORKON_HOME
fi

# Enable nose rednose plugin for colored output
export NOSE_REDNOSE=1

# ALIASES
# Easy file search
alias ff='~/bin/find-file.sh'
# Shortcut to gnome-open (opens files and dirs)
alias go='gnome-open 2> /dev/null'
# Same for Mac
alias open='gnome-open 2> /dev/null'
# Git bootstrap
alias git-boot='~/bin/git-boot.sh'
# Django script to run dev server on local IP
alias runserver='~/bin/django-runserver.sh'
# Remove pyc
alias rmpyc='find . -iname "*.pyc" -delete'
# Simple HTTP Server
alias simple-server='python -m SimpleHTTPServer'
# vim / xargs gvim
if [ `uname` == "Darwin" ]; then
    alias vim='mvim'
    alias xvim='xargs mvim'
else
    alias vim='gvim'
    alias xvim='xargs gvim'
fi

# Extra setup
[ -f ~/.bashprofile ] && . ~/.bashprofile

