" Vundle needs to be installed before:
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

" Use Vim settings, rather than Vi
set nocompatible

set fileformats=unix,dos

" Vundle
" Add this to .profile:
" export TERM=xterm-256color
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

" Vundle bundles!

" Theme
Plugin 'altercation/vim-colors-solarized'
Plugin 'chriskempson/base16-vim'

Plugin 'bling/vim-airline'
Plugin 'eiginn/netrw'
Plugin 'ctrlpvim/ctrlp.vim'
"Plugin 'Shougo/unite.vim'
Plugin 'tpope/vim-vinegar'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'mattn/emmet-vim'
Plugin 'mitsuhiko/vim-jinja'
"Plugin 'klen/python-mode'
Plugin 'majutsushi/tagbar'

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

set autochdir

" Solarized theme
set background=dark
" uncomment next line if unable to change terminal colors
"let g:solarized_termcolors=256
"colorscheme solarized
colorscheme base16-ocean

" indentation (size: 4)
set shiftwidth=4  " operation >> indents 4 columns; << unindents 4 columns
set tabstop=4     " a hard TAB displays as 4 columns
set softtabstop=4
set expandtab     " use spaces

" Python specific
" don't unindent comments
:inoremap # X<C-H>#
set wildignore+=*.pyc   " ignore .pyc in CtrlP, etc..

" backspace over everything in insert mode
set backspace=indent,eol,start

" line numbers
set number

" show cursor position always
set ruler

" showmatch: Show the matching bracket for the last ')'?
set showmatch

" highlight all search results
set hlsearch
" clear search string when entering insert mode
"autocmd InsertEnter * :let @/=""
"autocmd InsertLeave * :let @/=""

" append a $ character when changing a word
"set cpoptions+=$

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|silent! pclose|endif
autocmd InsertLeave * if pumvisible() == 0|silent! pclose|endif

" Plugins

" netrw/vinegar
let g:netrw_keepdir = 0
"let g:netrw_liststyle = 3
let g:netrw_preview = 1
let g:netrw_altv = 1

" CtrlP
let g:ctrlp_root_markers = ['pom.xml', '.p4ignore']

" Emmet
let g:user_emmet_leader_key='<C-e>'

" Syntastic
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = "--max-line-length=120"

" Python-Mode
let g:pymode_rope_complete_on_dot = 0
let g:pymode_lint = 0

" vim-gitgutter
let g:gitgutter_realtime=0  " don't update in realtime
let g:gitgutter_eager=0
" vim-gitgutter: fixes for solarized dark colorscheme
highlight clear SignColumn
autocmd ColorScheme * highlight clear SignColumn

" Tagbar
let g:tagbar_autoclose = 1  " autoclose when selecting
let g:tagbar_sort = 0  " dont sort
let g:tagbar_autoshowtag = 1
let g:tagbar_left = 1  " left/top position
let g:tagbar_vertical = 20
nmap <C-g> :TagbarToggle<CR>
