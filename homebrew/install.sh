#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)
HOME=~

source "$DOTFILES_ROOT/zsh/functions.zsh"

# Check for Homebrew
if test ! $(which brew)
then
  echo_info "  Installing Homebrew for you."

  # Install the correct homebrew for each OS type
  if test "$(uname)" = "Darwin"
  then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
  then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"
  fi
  echo_success "Homebrew installed"

fi


echo_info "brew bundle"
(cd homebrew; brew bundle)