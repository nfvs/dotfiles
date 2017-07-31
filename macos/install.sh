#!/usr/bin/env sh

set -e

cd "$(dirname "$0")/.."
HOME=~
DOTFILES_ROOT=$(pwd -P)

source $DOTFILES_ROOT/zsh/functions.zsh

# Install the Solarized Dark theme for iTerm
for src in $DOTFILES_ROOT/macos/*.itermcolors
do
	open "${src}"
	echo_success "Installed iTerm2 theme $(basename "${src}")"
done
