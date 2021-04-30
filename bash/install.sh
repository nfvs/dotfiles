#!/usr/bin/env bash

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)
HOME=~


if [ -s "$HOME/.bashrc"  ]; then
  echo "~/.bashrc already exists, add \"source $DOTFILES_ROOT/bash/_bashrc\" to it"
  exit 0
else
  echo "~/.bashrc does not exist, creating link to \"$DOTFILES_ROOT/bash/_bashrc\""
  ln -s $DOTFILES_ROOT/bash/_bashrc $HOME/.bashrc
fi
