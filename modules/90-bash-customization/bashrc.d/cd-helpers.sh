# Add work directory to CDPATH path
[ -d  "$HOME/work" ] && CDPATH="$CDPATH:$HOME/work"

cdgit(){
  cd "$(git rev-parse --show-toplevel)/$1"
}

# TODO: update relative path
cddotfiles(){
  local bashrc=$(readlink ~/.bashrc)
  local dotfiles=$(dirname $(dirname $bashrc))
  cd "$dotfiles"/$1
}
