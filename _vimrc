" Pathogen
"call pathogen#runtime_append_all_bundles()
"call pathogen#helptags()

" Default encoding: Utf-8
set encoding=utf-8

filetype plugin indent on

" Use Vim settings, rather than Vi
set nocompatible

"
set modelines=0

" UTF-8
set enc=utf-8

" syntax / colorscheme
syntax on
"colorscheme desert
"colorscheme wombat256

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

" Set status line
"set statusline=[%02n]\ %f\ %(\[%M%R%H]%)%=\ %4l,%02c%2V\ %P%*

" Always display a status line at the bottom of the window
"set laststatus=1

" showmatch: Show the matching bracket for the last ')'?
set number
set showmatch

" highlight all search results
" clear search string when entering insert mode
set hlsearch
autocmd InsertEnter * :let @/=""
autocmd InsertLeave * :let @/=""

" automatically remove trailing whitespace
"autocmd BufWritePre *.py :%s/\s\+$//e
