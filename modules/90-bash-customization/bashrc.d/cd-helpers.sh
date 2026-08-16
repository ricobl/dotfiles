# Add work directory to CDPATH path
[ -d "$HOME/work" ] && CDPATH="$CDPATH:$HOME/work"
[ -d "$HOME/projects" ] && CDPATH="$CDPATH:$HOME/projects"

cdgit(){
  cd "$(git rev-parse --show-toplevel)/$1"
}
