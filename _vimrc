" Vundle needs to be installed before:
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

" Use Vim settings, rather than Vi
set nocompatible

" Default encoding: Utf-8
set encoding=utf-8

" Vundle
" Add this to .profile:
" export TERM=xterm-256color
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/Vundle.vim'

" Vundle bundles!
Bundle 'altercation/vim-colors-solarized'
Bundle 'bling/vim-airline'
Bundle 'scrooloose/nerdtree'
Bundle 'nfvs/ctrlp.vim'
Bundle 'tpope/vim-vinegar'
Bundle 'klen/python-mode'
Bundle 'scrooloose/syntastic'

" re-enable filetype
filetype plugin indent on

" Disable modelines (why?)
set modelines=0
set nomodeline
set laststatus=2

" syntax
syntax on
set cursorline

" Solarized theme
set background=dark
" uncomment next line if unable to change terminal colors
"let g:solarized_termcolors=256
colorscheme solarized

" indentation (size: 4)
set textwidth=79  " lines longer than 79 columns will be broken
set shiftwidth=4  " operation >> indents 4 columns; << unindents 4 columns
set tabstop=4     " a hard TAB displays as 4 columns
set softtabstop=4 " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftround    " round indent to multiple of 'shiftwidth'
set autoindent    " align the new line indent with the previous line
set expandtab     " insert spaces when hitting TABs

" Python specific: don't unindent comments
:inoremap # X<C-H>#

" backspace over everything in insert mode
set backspace=indent,eol,start

" line numbers
set number

" show cursor position always
set ruler

" showmatch: Show the matching bracket for the last ')'?
set showmatch

" highlight all search results
" clear search string when entering insert mode
set hlsearch
autocmd InsertEnter * :let @/=""
autocmd InsertLeave * :let @/=""

" append a $ character when changing a word
"set cpoptions+=$

" Zen Coding
let g:user_zen_leader_key = '<c-e>'

" CtrlP
let g:ctrlp_custom_ancestors = ['pom.xml', '.p4ignore']
