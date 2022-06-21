#!/usr/bin/env bash

cd "$(dirname "$0")/.."
DOTFILES_ROOT=~/.dotfiles
HOME=~

# Symlink already exists?
# if [[ -s "$HOME/.bashrc" && -h "$HOME/.bashrc" ]]; then
#   echo "~/.bashrc already exists, add \"source $DOTFILES_ROOT/bash/_bashrc\" to it"
#   exit 0
# # Regular file exists; rename to `.bashrc.orig`, then import it at the end
# elif [[ -s "$HOME/.bashrc" ]]; then
#   echo "~/.bashrc already exists, renaming it to ~/.bashrc.orig and importing it"
#   mv $HOME/.bashrc $HOME/.bashrc.orig
#   ln -s $DOTFILES_ROOT/bash/_bashrc $HOME/.bashrc
#   echo "source \$HOME/.bashrc.orig" >> $HOME/.bashrc
# elif [[ ! -e "$HOME/.bashrc" ]]; then
#   echo "~/.bashrc does not exist, creating link to \"$DOTFILES_ROOT/bash/_bashrc\""
#   ln -s $DOTFILES_ROOT/bash/_bashrc $HOME/.bashrc
# else
#   echo "Unknown ~/.bashrc state, doing nothing."
# fi
