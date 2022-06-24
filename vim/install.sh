#!/usr/bin/env sh

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

# Create the symlink immediately so that vim-plug gets installed in the correct place
if [ ! -h $HOME/.vim ]; then
    if [ -d $HOME/.vim ]; then
        cp -R $HOME/.vim $HOME/.vim.backup
    fi
    ln -s $DOTFILES_ROOT/vim/_vim $HOME/.vim
fi

if [ ! -f $HOME/.vim/autoload/plug.vim ] ; then
    curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

vim +PlugInstall +quitall

# Import vim config into Neovim
mkdir -p $HOME/.config/nvim
echo "set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc" > $HOME/.config/nvim/init.vim