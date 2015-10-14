function init -a path --on-event init_env-vars
    # Disable python byte-code
    set -gx PYTHONDONTWRITEBYTECODE 1
    # Enable pip download cache
    set -gx PIP_DOWNLOAD_CACHE "$HOME/.pip/cache"
end

