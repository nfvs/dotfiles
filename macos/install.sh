#!/usr/bin/env sh

set -e

cd "$(dirname "$0")/.."
HOME=~
DOTFILES_ROOT=$(pwd -P)

source $DOTFILES_ROOT/zsh/functions.zsh

# Install the Solarized Dark theme for iTerm
# theme=base16-oceanicnext.dark
# for src in $DOTFILES_ROOT/macos/themes/$theme.itermcolors
# do
# 	open "${src}"
# 	echo_success "Installed iTerm2 theme $(basename "${src}")"
# done

$DOTFILES_ROOT/macos/set-defaults.sh