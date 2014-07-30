" Vundle needs to be installed before:
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

" Use Vim settings, rather than Vi
set nocompatible

" Vundle
" Add this to .profile:
" export TERM=xterm-256color
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle
Bundle 'gmarik/Vundle.vim'

" Vundle bundles!
Bundle 'altercation/vim-colors-solarized'
Bundle 'bling/vim-airline'
Bundle 'eiginn/netrw'
Bundle 'nfvs/ctrlp.vim'
Bundle 'tpope/vim-vinegar'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-fugitive'
Bundle 'mattn/emmet-vim'

call vundle#end()

" re-enable filetype
filetype plugin indent on

" Default encoding: Utf-8
set encoding=utf-8

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
set shiftwidth=4  " operation >> indents 4 columns; << unindents 4 columns
set tabstop=4     " a hard TAB displays as 4 columns

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

" Emmet
let g:user_emmet_leader_key='<C-E>'

" Python-Mode
let g:pymode_rope_complete_on_dot = 0
let g:pymode_lint = 0

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|silent! pclose|endif
autocmd InsertLeave * if pumvisible() == 0|silent! pclose|endif

" Perforce!
" When writing a read-only file, try to open it in P4
"autocmd BufWritePre * :if &readonly && confirm('File is read only. Open for edit?', "&Yes\n&No", 1) == 1 | !p4 edit %

