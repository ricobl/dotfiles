function uninstall --on-event uninstall_env-vars
    set -ge PYTHONDONTWRITEBYTECODE
    set -ge PIP_DOWNLOAD_CACHE
end
