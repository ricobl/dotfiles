function uninstall --on-event uninstall_less-colors
    set -ge LESS_TERMCAP_mb
    set -ge LESS_TERMCAP_so
    set -ge LESS_TERMCAP_md
    set -ge LESS_TERMCAP_me
    set -ge LESS_TERMCAP_se
    set -ge LESS_TERMCAP_ue
    set -ge LESS_TERMCAP_us
end
