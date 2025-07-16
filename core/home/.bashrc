# Identify the real origin of this file and expand symlink if needed
bash_rc_filepath="${BASH_SOURCE[0]}"
if [ -L "$bash_rc_filepath" ]; then
  bash_rc_filepath="$(readlink "$bash_rc_filepath")"
fi

# Find the relative root of the project and set DOTFILES_ROOT
DOTFILES_ROOT="$(cd "$(dirname "$bash_rc_filepath")/../.." && pwd)"

# Load the core bashrc
source "$DOTFILES_ROOT/core/bashrc"
