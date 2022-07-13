DEFAULT_USER=`whoami`

export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8


HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt NO_BG_NICE # don't nice background tasks
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS # allow functions to have local traps
setopt HIST_VERIFY
# setopt SHARE_HISTORY # share history between sessions ???
setopt NO_SHARE_HISTORY
setopt EXTENDED_HISTORY # add timestamps to history
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
# setopt IGNORE_EOF

# setopt APPEND_HISTORY # adds history
setopt INC_APPEND_HISTORY  # adds history incrementally...
setopt SHARE_HISTORY  # ...and share it across sessions
setopt HIST_IGNORE_ALL_DUPS  # don't record dupes in history
setopt HIST_REDUCE_BLANKS

# don't expand aliases _before_ completion has finished
#   like: git comm-[tab]
setopt complete_aliases

zle -N newtab

bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line
bindkey '^[[3~' delete-char
bindkey '^[^N' newtab
bindkey '^?' backward-delete-char

# OSX: fn-arrows
# bindkey "^[[1~" beginning-of-line
# bindkey "^[[4~" end-of-line
# bindkey '^[[H' beginning-of-line
# bindkey '^[[F' end-of-line
