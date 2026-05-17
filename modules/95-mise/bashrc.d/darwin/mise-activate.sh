# Mise needs to be applied after bash-customizations as it
# overrides PROMPT_COMMAND

if [[ -e ~/.local/bin/mise ]]; then
  # Activate and add to PATH
  eval "$(~/.local/bin/mise activate bash)"
  # Enabling completion outputs a lot of errors but ends up working anyway
  eval "$(mise completion bash)"
fi
