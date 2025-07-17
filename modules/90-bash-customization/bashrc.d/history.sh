HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoreboth
# Make some commands not show up in history
HISTIGNORE="ls:cd:cd -:pwd:exit"

# Append to the history file, don't overwrite it
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s histappend checkwinsize
