#!/usr/bin/env bash

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)
HOME=~

mkdir -p $HOME/.ssh
ln -fs $DOTFILES_ROOT/ssh/rc $HOME/.ssh/rc