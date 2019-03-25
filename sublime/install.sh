#!/usr/bin/env bash
# Setup a machine for Sublime Text

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)
HOME=~

source $DOTFILES_ROOT/zsh/functions.zsh

if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "Sublime setup supported only on MacOS, skipping."
    exit 0
fi

SUBLIME_DIR=~/Library/Application\ Support/Sublime\ Text\ 3/Packages

mkdir -p "$SUBLIME_DIR/Default"
for file_path in $DOTFILES_ROOT/sublime/Default/*; do
  [[ -f "$file_path" ]] || continue
  basename=$(basename "$file_path")
  echo_info "sublime: linking Default/$basename"
  ln -sfv "$file_path" "$SUBLIME_DIR/Default/$basename" 1>/dev/null
done

mkdir -p "$SUBLIME_DIR/User"
for file_path in $DOTFILES_ROOT/sublime/User/*; do
  [[ -f "$file_path" ]] || continue
  basename=$(basename "$file_path")
  echo_info "sublime: linking User/$basename"
  ln -sfv "$file_path" "$SUBLIME_DIR/User/$basename" 1>/dev/null
done

echo_success "sublime setup done"
