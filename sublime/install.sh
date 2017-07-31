#!/usr/bin/env sh
# Setup a machine for Sublime Text

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)
HOME=~

SUBLIME_DIR=~/Library/Application\ Support/Sublime\ Text\ 3/Packages


mkdir -p "$SUBLIME_DIR/Default"
for file_path in $DOTFILES_ROOT/sublime/Default/*; do
  [[ -f "$file_path" ]] || continue
  basename=$(basename "$file_path")
  echo "Linking Default/$basename"
  ln -sfv "$file_path" "$SUBLIME_DIR/Default/$basename" 1>/dev/null
done

mkdir -p "$SUBLIME_DIR/User"
for file_path in $DOTFILES_ROOT/sublime/User/*; do
  [[ -f "$file_path" ]] || continue
  basename=$(basename "$file_path")
  echo "Linking User/$basename"
  ln -sfv "$file_path" "$SUBLIME_DIR/User/$basename" 1>/dev/null
done

# echo "Linking User"
# ln -sfv "$DOTFILES_ROOT/sublime/User" "$SUBLIME_DIR/" 1>/dev/null

echo "Done!"
