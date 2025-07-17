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
alias grep="grep --color=auto"
