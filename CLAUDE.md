# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```sh
# Install symlinks to home directory (safe to re-run; skips existing files)
./scripts/install.sh

# Run all tests (requires Docker)
make test
# or
scripts/run-tests.sh

# Run a specific test file
scripts/run-tests.sh tests/test_integration.bats
```

## Architecture

This is a **custom modular dotfiles system** — no stow/chezmoi. The install script (`scripts/install.sh`) symlinks files from each module's `home/` directory into `$HOME`. It skips (never overwrites) existing files/symlinks; remove manually to replace.

### Module structure

```
modules/<NN>-<name>/
├── bashrc.d/          # Sourced on new shell startup
│   ├── darwin/        # macOS-only
│   └── linux/         # Linux-only
├── bin/               # Added to $PATH
│   ├── darwin/
│   └── linux/
└── home/              # Symlinked into $HOME on install
```

The numeric prefix controls **load order** (alphabetical). Lower numbers load earlier — `00-system` before `01-brew` before `10-bash-completion`, etc. Use prefixes when a module depends on another being initialized first.

### Shell initialization chain

`~/.bashrc` → `core/bashrc` → sources all `modules/*/bashrc.d/*.sh` in module order → sources OS-specific `darwin/` or `linux/` subdirs → finally loads user overrides from `~/.dotfiles/bashrc.d/*.sh`.

### Adding a new module

1. Create `modules/<NN>-<name>/` with the subdirs you need.
2. Re-run `./scripts/install.sh` to link any `home/` files.
3. New `bashrc.d/` and `bin/` entries are picked up automatically on the next shell start.

### Tests

BATS-based integration tests in `tests/`. CI runs them in the `bats/bats:latest` Docker container via GitHub Actions on push/PR to master.
