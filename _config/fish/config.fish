if status is-interactive
    # Keybindings
    # NOTE: For "history-pager-delete" to work with shift-delete in iTerm2,
    # add the "Shift Del" Keyboard Shortcut with "Send Escape Sequence": "[3;2~"

    # Bind shift-up/down to search prefix, like bash/zsh up/down
    bind \e\[1\;2A history-prefix-search-backward
    bind \e\[1\;2B history-prefix-search-forward

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
