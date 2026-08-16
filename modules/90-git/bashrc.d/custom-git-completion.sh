# Extend completion to other commands like `git ls-files`
export GIT_COMPLETION_SHOW_ALL_COMMANDS=1

_git_quick_amend() {
  _git_commit
}
