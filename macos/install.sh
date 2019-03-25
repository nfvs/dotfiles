#!/usr/bin/env bash

set -e

cd "$(dirname "$0")/.."
HOME=~
DOTFILES_ROOT=$(pwd -P)

source $DOTFILES_ROOT/zsh/functions.zsh

# echo_info "› Installing macOS defaults"
# "$DOTFILES_ROOT/macos/set-defaults.sh"
