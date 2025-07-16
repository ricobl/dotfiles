# Enable bash completion if available
_etc_completion=`brew --prefix`/etc/bash_completion
[[ -f $_etc_completion ]] && . $_etc_completion
