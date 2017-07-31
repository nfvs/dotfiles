#!/usr/bin/env sh

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)
HOME=~

ln -sfh "$DOTFILES_ROOT" $HOME/.dotfiles
source $DOTFILES_ROOT/zsh/functions.zsh

# ZSH setup
if [ ! -d "$HOME/.oh-my-zsh" ] ; then
    git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
    echo_success "Oh-My-ZSH installed"
else
    (cd $HOME/.oh-my-zsh; git pull)
    echo_success "Oh-My-ZSH updated"
fi

# Install themes
if [ ! -d "$HOME/.zsh-pure" ] ; then
    git clone git://github.com/sindresorhus/pure.git "$HOME/.zsh-pure"
    echo_success "ZSH Pure installed"
else
    (cd $HOME/.zsh-pure; git pull)
    echo_success "ZSH Pure updated"
fi

mkdir -p $HOME/.zfunctions
ln -fs "$HOME/.zsh-pure/pure.zsh" $HOME/.zfunctions/prompt_pure_setup
ln -fs "$HOME/.zsh-pure/async.zsh" $HOME/.zfunctions/async

ln -fs "$DOTFILES_ROOT/zsh/_zshrc" $HOME/.zshrc
echo_success "ZSH setup done"