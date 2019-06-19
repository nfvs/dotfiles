alias reload!='. ~/.zshrc'

alias cls='clear' # Good 'ol Clear Screen command
alias venv='source ./.venv/bin/activate'

# Start a new tmux session with 3 panes
alias tmux-new='tmux new-session \; split-window -h \; split-window -v \; attach'

# Perforce
alias p4home="p4 -Ztag -F %clientRoot% info"
