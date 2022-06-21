#!/usr/bin/env sh

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

if [ ! -f ~/.vim/autoload/plug.vim ] ; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

vim +PlugInstall +quitall

# Import vim config into Neovim
mkdir -p $HOME/.config/nvim
echo "set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc" > $HOME/.config/nvim/init.vim