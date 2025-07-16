#!/usr/bin/env bash

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
  local color=$1
  local message=$2
  echo -e "${color}${message}${NC}"
}

is_symlink() {
  [ -L "$1" ]
}

get_symlink_target() {
  readlink "$1" 2>/dev/null || echo ""
}

# Safely create a symlink and print message if target already exists
create_symlink() {
  local source_file="$1"
  local target_file="$2"

  # Check if target already exists
  if is_symlink "$target_file"; then
    local current_target=$(get_symlink_target "$target_file")
    print_status $YELLOW "Skipping $target_file: symlink exists pointing to $current_target"
    return 0
  elif [ -e "$target_file" ]; then
    print_status $YELLOW "Skipping $target_file: destination exists"
    return 0
  fi

  # Create the symlink
  if ln -sf "$source_file" "$target_file"; then
    print_status $GREEN "Created symlink: $target_file"
  else
    print_status $RED "Failed to create symlink: $target_file"
    return 1
  fi
}

# Function to install files from a home directory
install_home_files() {
  local source_dir="$1"

  [ -d "$source_dir" ] || return 0

  # Look hidden files in the module's home directory
  for file in "$source_dir"/.*; do
    # File may be the actual glob pattern if no file is found,
    # so to check for existence to ensure it's a file or directory
    [ -e "$file" ] || continue

    local filename=$(basename "$file")
    local target="$HOME/$filename"

    create_symlink "$file" "$target"
  done
}

# Main installation function
install_dotfiles() {
  local dotfiles_root
  dotfiles_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

  # Point DOTFILES_DIR to the root of the project if not already set
  if [ -z "$DOTFILES_DIR" ]; then
    DOTFILES_DIR="$dotfiles_root"
  fi

  # Process core/home directory
  print_status $BLUE "Installing module: core..."
  install_home_files "$dotfiles_root/core/home"

  # Process modules/*/home directories
  for module_dir in "$DOTFILES_DIR/modules"/*; do
    [ -d "$module_dir/home" ] || continue

    print_status $BLUE "Installing module: $(basename "$module_dir")..."
    install_home_files "$module_dir/home"
  done

  print_status $GREEN "Installation completed!"
}

# Run installation
main() {
  install_dotfiles
}

# Run main function
main "$@"
