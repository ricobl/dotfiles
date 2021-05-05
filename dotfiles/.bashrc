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

c_prompt=`color 0 33`
c_path=`color 1 33`
c_branch=`color 1 32`
c_tag=`color 1 34`
c_off=`color 0 00`

function git_branch {
    __git_ps1 " %s"
}

function git_tag {
    tag=`git tag -l --points-at HEAD 2> /dev/null | xargs echo`
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
    # Disable analytics on homebrew
    export HOMEBREW_NO_ANALYTICS=1
else
    alias ls='ls --color=auto'
    # Same as Mac's open
    alias open='gnome-open 2> /dev/null'
fi

set -o vi

# EASY FILE FIND
# Disable glob expansion for find-file (ff) and seek
# http://blog.edwards-research.com/2011/05/preventing-globbing/
__ff(){ ~/bin/find-file.sh "$@"; set +f; }
__seek(){ ~/bin/seek.sh "$@"; set +f; }

alias ff='set -f; __ff'
alias seek='set -f; __seek'
alias vim='~/bin/vim-proxy.py'
alias xvim="xargs ~/bin/vim-proxy.py; set +f"
alias xcode="xargs code"
alias ll="ls -l"
# Faster and better grep options
alias grep="grep --color=auto --exclude=*.pyc -I"

# Bind Ctrl+l to clear terminal
bind -x '"\C-l":printf "\ec"'

# Add user bin to the path
[ -d  "$HOME/bin" ] && PATH="$PATH:$HOME/bin"

# Add work directory to CDPATH path
[ -d  "$HOME/work" ] && CDPATH="$CDPATH:$HOME/work"

quick_workon(){
    source "$WORKON_HOME/$1/bin/activate"
}
# Virtualenvs
if [[ -f '/usr/local/bin/virtualenvwrapper_lazy.sh' ]]; then
    export VIRTUALENVWRAPPER_PYTHON=`which python2.7`
    export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
    source "/usr/local/bin/virtualenvwrapper_lazy.sh"

    # Activate latest virtualenv or a default one
    # Based on: http://unfoldthat.com/2011/08/18/virtualenv-in-new-terminal-windows.html
    if [ -e "$WORKON_HOME/last_venv" ]; then
        quick_workon `cat "$WORKON_HOME/last_venv"`
    elif [ -n "$DEFAULT_VIRTUAL_ENV" ]; then
        quick_workon "$DEFAULT_VIRTUAL_ENV"
    fi
fi

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

export IPYTHONDIR="~/.ipython"
# Enable nose rednose plugin for colored output
export NOSE_REDNOSE=1
export PYTHONDONTWRITEBYTECODE=1

# Enable links with Delta / git diff
export DELTA_PAGER='less -rX'

pycd(){
    module_dir="`python -c "import pkgutil;print pkgutil.get_loader('$1').filename"`"
    \cd "$module_dir"
}

cdgit(){
    cd "$(git rev-parse --show-toplevel)/$1"
}
cddotfiles(){
    local bashrc=$(readlink ~/.bashrc)
    local dotfiles=$(dirname $(dirname $bashrc))
    cd "$dotfiles"/$1
}

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

PATH="~/Android/Sdk/tools:~/Android/Sdk/platform-tools:${PATH}"

export ANDROID_HOME=~/Android/Sdk
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export FZF_DEFAULT_OPTS="--bind ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
