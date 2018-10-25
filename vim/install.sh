#!/usr/bin/env sh

# Need to create the symlink first
ln -sf $DOTFILES_ROOT/vim/_vim ~/.vim

if [ ! -d ~/.vim/bundle/Vundle.vim ] ; then
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
vim +PluginInstall +quitall