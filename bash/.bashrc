# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm|xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# Dark colors
cd_black="\[\033[0;30m\]"
cd_red="\[\033[0;31m\]"
cd_green="\[\033[0;32m\]"
cd_yellow="\[\033[0;33m\]"
cd_blue="\[\033[0;34m\]"
cd_magenta="\[\033[0;35m\]"
cd_cyan="\[\033[0;36m\]"
cd_white="\[\033[0;37m\]"
# Light colors
cl_black="\[\033[1;30m\]"
cl_red="\[\033[1;31m\]"
cl_green="\[\033[1;32m\]"
cl_yellow="\[\033[1;33m\]"
cl_blue="\[\033[1;34m\]"
cl_magenta="\[\033[1;35m\]"
cl_cyan="\[\033[1;36m\]"
cl_white="\[\033[1;37m\]"
# Color off
c_off="\[\033[0;00m\]"

c_prompt=$cd_yellow
c_path=$cl_yellow
c_git=$cl_green

function git_branch {
	branch=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ -n "$branch" ]; then
        tag=`git describe --exact-match --tags HEAD 2> /dev/null`
        if [ -n "$tag" ]; then
            echo "TAG $tag"
            return
        fi
    fi
    echo "$branch"
}

if [ "$color_prompt" = yes ]; then
    #PS1='\[\033[0;33m\][\u@\h \[\033[1;33m\]\W\[\033[0;33m\]] \[\033[0;00m\]'
    PS1="${c_prompt}[${c_prompt}\u@\h ${c_path}\W${c_prompt}${c_git} \$(git_branch)${c_prompt}]${c_off} "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
	# Load fabfile completion
    . ~/bin/fab_bash_completion
fi

# Add user bin to the path
[ -d  "$HOME/bin" ] && PATH="$PATH:$HOME/bin"

export WORKON_HOME="$HOME/.virtualenvs"
source "/usr/local/bin/virtualenvwrapper.sh"

if [ -f ~/.bashprofile ]; then
    . ~/.bashprofile
fi

