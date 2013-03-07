" Default encoding: Utf-8
set encoding=utf-8

" Vundle
" Add this to .profile:
" export TERM=xterm-256color
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" Vundle bundles!
Bundle 'altercation/vim-colors-solarized'
Bundle 'wincent/Command-T'

" re-enable filetype
filetype plugin indent on

" Use Vim settings, rather than Vi
set nocompatible

" Disable modelines (why?)
set modelines=0
set nomodeline

" UTF-8
set enc=utf-8

" syntax
syntax on

" Solarized theme
set background=dark
" uncomment next line if unable to change terminal colors
"let g:solarized_termcolors=256
colorscheme solarized

" indentation (size: 4)
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
"set softtabstop=4

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

" Zen Coding
let g:user_zen_leader_key = '<c-e>'
