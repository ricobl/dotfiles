OS=`uname`

HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoredups
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
PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"

unset c_prompt c_path c_branch c_tag c_off

# Colors for Man Pages
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
# Pip + virtualenv
export WORKON_HOME="$HOME/.virtualenvs"
export PIP_RESPECT_VIRTUALENV=true
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_DOWNLOAD_CACHE="$HOME/.pip/cache"

if [ $OS == "Darwin" ]; then
    alias ls='ls -G'
    # Change paths as required for homebrew
    PATH="/usr/local/bin:/usr/local/sbin:$PATH"
else
    alias ls='ls --color=auto'
    # Same as Mac's open
    alias open='gnome-open 2> /dev/null'
fi

alias grep='grep --color=auto'
alias vim='~/bin/vim-proxy.sh'
alias xvim="xargs ~/bin/vim-proxy.sh"

# Add user bin to the path
[ -d  "$HOME/bin" ] && PATH="$PATH:$HOME/bin"

# Virtualenvs
if [[ -f '/usr/local/bin/virtualenvwrapper.sh' ]]; then
    source "/usr/local/bin/virtualenvwrapper.sh"

    # Activate latest virtualenv or a default one
    # Based on: http://unfoldthat.com/2011/08/18/virtualenv-in-new-terminal-windows.html
    if [ -e "$WORKON_HOME/last_venv" ]; then
        workon `cat "$WORKON_HOME/last_venv"`
    elif [ -n "$DEFAULT_VIRTUAL_ENV" ]; then
        workon "$DEFAULT_VIRTUAL_ENV"
    fi
fi

# Enable bash completion if available
[[ -f '/etc/bash_completion' ]] && . /etc/bash_completion

# Fabric, vagrant, django and pip completion
. ~/bin/fab_bash_completion
[[ -n `which pip` ]] && eval "`pip completion --bash`"

export IPYTHON_DIR="~/.ipython"
# Enable nose rednose plugin for colored output
export NOSE_REDNOSE=1

# EASY FILE FIND
# Disable glob expansion for find-file (ff)
# http://blog.edwards-research.com/2011/05/preventing-globbing/ 
__ff(){ ~/bin/find-file.sh "$@"; set +f; }
alias ff='set -f; __ff'

function pycd {
    module_dir="`python -c "import $1; print $1.__file__" | xargs dirname`"
    \cd "$module_dir"
}

# Extra setup
[ -f ~/.bashprofile ] && . ~/.bashprofile

