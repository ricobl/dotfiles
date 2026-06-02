# here

Run directory-scoped scripts without cluttering your working directories.

Scripts are stored centrally under `~/.here/`, keyed by the directory you're in when you create them. This keeps your project directories clean while still letting you define per-project helper commands.

## Storage layout

When you run `here` from `/Users/alice/projects/myapp`, scripts are stored at:

```
~/.here/HOME~projects~myapp/
```

`$HOME` is replaced with `HOME`, and `/` is replaced with `~`, producing a flat directory name that maps one-to-one with your working directory.

Global scripts — available from any directory — are stored at:

```
~/.here/_global/
```

## Usage

```
here [--option] [command] [args...]
```

### Running a script

```sh
here build          # runs ~/.here/<cwd>/build, falls back to ~/.here/_global/build
here deploy staging # runs ~/.here/<cwd>/deploy staging
```

When a script is not found in the current directory's storage, `here` falls back to the global store before reporting an error.

### Managing scripts

| Command                       | Description                                                             |
| ----------------------------- | ----------------------------------------------------------------------- |
| `here --create <name>`        | Create a local script and open it in `$EDITOR`                          |
| `here --edit <name>`          | Open a local script in `$EDITOR`                                        |
| `here --show <name>`          | Print a script with syntax highlighting (`hicat`); falls back to global |
| `here --list`                 | List scripts for the current directory and global store                 |
| `here --dir`                  | Print the local storage path for the current directory                  |
| `here --global-create <name>` | Create a global script and open it in `$EDITOR`                         |
| `here --global-edit <name>`   | Open a global script in `$EDITOR`                                       |
| `here --global-dir`           | Print the global storage path                                           |

### Creating a script

```sh
here --create deploy
```

Opens a new executable bash script in your editor with a starter template. The file is created at `~/.here/<cwd>/deploy` and made executable automatically.

You can also pass initial content inline:

```sh
here --create greet 'echo "hello from $(pwd)"'
here --global-create bump-version 'git tag v$1 && git push --tags'
```

### Global scripts

Global scripts are available regardless of which directory you're in. They are a good fit for utility commands that aren't tied to a specific project.

```sh
here --global-create git-cleanup 'git branch --merged | grep -v master | xargs git branch -d'
here git-cleanup   # works from any directory
```

Local scripts take precedence: if both `~/.here/<cwd>/foo` and `~/.here/_global/foo` exist, the local one runs.

`here --list` shows both tiers with section headers when scripts exist in both:

```
local:
  build
  deploy

global:
  git-cleanup
  bump-version
```

## Bash completion

Tab completion is provided for both options and script names. After `here <tab>`, you'll see available options and any scripts that exist for the current directory or the global store. After `here --edit <tab>` or `here --show <tab>`, local script names are completed; after `here --global-edit <tab>`, global script names are completed.

## Dependencies

- `hicat` — required for `here --show` (syntax-highlighted output)
- `$EDITOR` — used by `--create`, `--edit`, `--global-create`, and `--global-edit`; falls back to `code` if unset
