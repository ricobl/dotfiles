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
c_path=`color 0 32`
c_branch=`color 0 31`
c_tag=`color 1 34`
c_off=`color 0 00`

function git_branch {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function git_tag {
    tag=`git describe --exact-match --tags HEAD 2> /dev/null`
    [ -z "$tag" ] && return 1

    echo " $tag"
}

PS1="${c_prompt}[\u@\h ${c_path}\W$c_branch\$(git_branch)$c_tag\$(git_tag)${c_prompt}]${c_off} "

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

unset color_prompt force_color_prompt
unset c_prompt c_path c_branch c_tag c_off

# Enable bash completion if available
[[ -f '/etc/bash_completion' ]] && . /etc/bash_completion

# Fabric, vagrant, django and pip completion
. ~/bin/fab_bash_completion
[[ -n `which pip` ]] && eval "`pip completion --bash`"





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

# Shortcuts
# =========
alias mv="mv -i"
alias cp="cp -i"
alias grep='grep --color=auto'
alias vim="$VIM --remote-tab-silent"
alias xvim="xargs $VIM --remote-tab-silent > /dev/null"
if [ `uname` == "Darwin" ]; then
    alias ls='ls -G'
else
    alias ls='ls --color=auto'
fi


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

if [ $OS == "Darwin" ]; then
    VIM='mvim'
    alias ls='ls -G'
    # Change paths as required for homebrew
    PATH="/usr/local/bin:/usr/local/sbin:$PATH"
else
    VIM='gvim'
    alias ls='ls --color=auto'
    # Same as Mac's open
    alias open='gnome-open 2> /dev/null'
fi

# EASY FILE FIND
# Disable glob expansion for find-file (ff)
# http://blog.edwards-research.com/2011/05/preventing-globbing/ 
__ff(){ ~/bin/find-file.sh "$@"; set +f; }
alias ff='set -f; __ff'

function pycd {
    module_dir="`python -c "import $1; print $1.__file__" | xargs dirname`"
    \cd "$module_dir"
}


