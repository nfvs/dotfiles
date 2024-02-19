if status is-interactive
    # Keybindings

    # Bind up/down to search prefix, like bash/zsh
    # bind \e\[A history-prefix-search-backward
    # bind \e\[B history-prefix-search-forward

    # Shift delete: delete entry from Ctrl-R pager
    # Also remove the "or backward-delete-char", otherwise arrows after deleting
    # an entry will send an escape character.
    # NOTE: For "history-pager-delete" to work with shift-delete in iTerm2,
    # add the "Shift Del" Keyboard Shortcut with "Send Escape Sequence": "[3;2~"
    bind -k sdc history-pager-delete

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
