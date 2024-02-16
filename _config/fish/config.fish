if status is-interactive
    # Don't exit on accidental Ctrl-D; exit on the third one!
    bind \cd delete-char
    bind \cd\cd\cd delete-or-exit

    # Aliases

    # Use nvim if available
    if type -q nvim
        alias vim="nvim"
    end

    # Starship prompt (https://starship.rs)
    starship init fish | source
end
