#!/usr/bin/env bash

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)
HOME=~

ln -fs "$HOME/.dotfiles/zsh/_zshenv" $HOME/.zshenv
source $HOME/.dotfiles/zsh/functions.zsh

# ZSH setup
if [ ! -d "$HOME/.oh-my-zsh" ] ; then
    git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
    echo_success "Oh-My-ZSH installed"
else
    (cd $HOME/.oh-my-zsh; git pull)
    echo_success "Oh-My-ZSH updated"
fi

# Install themes
if [ ! -d "$HOME/.zsh-pure" ] ; then
    git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh-pure"
    echo_success "ZSH Pure installed"
else
    (cd $HOME/.zsh-pure; git pull)
    echo_success "ZSH Pure updated"
fi

mkdir -p $HOME/.zfunctions
ln -fs "$HOME/.zsh-pure/pure.zsh" $HOME/.zfunctions/prompt_pure_setup
ln -fs "$HOME/.zsh-pure/async.zsh" $HOME/.zfunctions/async

ln -fs "$HOME/.dotfiles/zsh/_zshrc" $HOME/.zshrc
echo_success "ZSH setup done"

