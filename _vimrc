" remove all existing autocmds
autocmd!

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
Plug 'cespare/vim-toml'
Plug 'chriskempson/base16-vim'
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'leafgarland/typescript-vim'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'mhinz/vim-signify'
Plug 'mileszs/ack.vim'
Plug 'mxw/vim-jsx'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set encoding=utf-8
set fileformats=unix,dos
set history=10000
set updatetime=250
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set laststatus=2
set noshowmode
"set hidden
set autoread
set nonumber
set showmatch
set incsearch
set hlsearch
set foldlevel=20
"set cursorline
set autochdir
"set ruler
set cmdheight=1
set switchbuf=useopen
"set showtabline=2  " Always show tab bar at the top
set winwidth=79
"set nowrap
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
" set t_ti= t_te=
" keep more context when scrolling off the end of a buffer
set scrolloff=3
" allow backspace over everything in insert mode
set backspace=indent,eol,start
set wildmenu
set wildignore+=*/tmp/*,*/node_modules/*,*.so,*.swp,*.zip,*.pyc,*/.git/*
set diffopt+=vertical
" Syntax
syntax on
filetype plugin indent on
" clear search string when entering insert mode
"autocmd InsertEnter * :let @/=""
"autocmd InsertLeave * :let @/=""

" Vim seems to have issues with `screen-256color`
if !has('nvim') && &term =~ 'screen'
  set term=xterm-256color
endif

" Undofile
if exists('+undofile')
  set undofile
  if has('nvim')
    setglobal undodir=~/.cache/nvim/undo
  else
    setglobal undodir=~/.cache/vim/undo
  endif
  if !isdirectory(&undodir)
    call mkdir(&undodir, 'p')
  endif

  " delete more than 90-day-old undo files
  let s:undofiles = split(globpath(&undodir, '*'), "\n")
  call filter(s:undofiles, 'getftime(v:val) < localtime() - (60 * 60 * 24 * 90)')
  call map(s:undofiles, 'delete(v:val)')
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
if (has("termguicolors"))
  set termguicolors
endif
"colorscheme solarized8_flat
"silent! colorscheme OceanicNext
silent! colorscheme base16-oceanicnext


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocmds
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!

  " Reload file when regaining focus
  autocmd CursorHold,CursorHoldI,FocusGained,BufEnter * :checktime

  autocmd BufRead,BufNewFile *.toml setfiletype=toml

  " Indent with 2 spaces only:
  autocmd FileType yaml set foldmethod=indent
  autocmd FileType haml,yaml,html,sass,scss,json,toml set ai sw=2 sts=2 et
  autocmd FileType javascript set ai si sw=2 sts=2 et

  " If you prefer the Omni-Completion tip window to close when a selection is
  " made, these lines close it on movement in insert mode or when leaving
  " insert mode
  autocmd CursorMovedI * if pumvisible() == 0|silent! pclose|endif
  autocmd InsertLeave * if pumvisible() == 0|silent! pclose|endif

  " FZF
  command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
    \   <bang>0 ? fzf#vim#with_preview('up:60%')
    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    \   <bang>0)

augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keymaps
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move up and down in autocomplete with <c-j> and <c-k>
" inoremap <expr> <c-j> ("\<C-n>")
" inoremap <expr> <c-k> ("\<C-p>")
inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"

" Python: don't unindent comments
:inoremap # X<C-H>#

" FZF
nnoremap <leader>f :Files<CR>
nnoremap <leader>g :GFiles<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>h :History<CR>
" Ctrl-P default: Gfiles, with Files fallback
nnoremap <expr> <C-p> (len(system('git rev-parse')) ? ':Files' : ':GFiles')."\<cr>"

" tagbar
nmap <leader>t :TagbarToggle<CR>

" vim-signify
nnoremap <leader>d :SignifyToggle<CR>
nmap ]c <plug>(signify-next-hunk)
nmap [c <plug>(signify-prev-hunk)
nnoremap ]C 9999]c
nnoremap [C 9999[c

" ALE
nnoremap <silent> gd :ALEGoToDefinition<CR>
nnoremap <silent> gr :ALEFindReferences<CR>
nnoremap <silent> K :ALEHover<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" netrw/vinegar
"let g:netrw_liststyle = 3
let g:netrw_keepdir = 0
let g:netrw_preview = 1
let g:netrw_altv = 1
let g:netrw_fastbrowse = 0  " default=1 leads to duplicate files

" CtrlP
" let g:ctrlp_root_markers = ['pom.xml', '.p4ignore']
" let g:ctrlp_show_hidden = 1
" " Skip files inside gitignore
" let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
" if executable('rg')
"   set grepprg=rg\ --color=never
"   let g:ctrlp_user_command = 'rg %s --files --hidden --color=never --glob ""'
"   let g:ctrlp_use_caching = 0
" endif

" Emmet
let g:user_emmet_leader_key='<C-e>'
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\  },
\}

" Python-Mode
let g:pymode_rope = 0
"let g:pymode_rope_complete_on_dot = 0
let g:pymode_lint = 0
let g:pymode_folding = 0
let g:pymode_options_colorcolumn = 0

" Ale
"let g:ale_lint_on_text_changed = 'normal'
let g:ale_linters = {
\   'python': ['flake8', 'pydocstyle'],
\   'javascript': ['eslint'],
\   'javascript.jsx': ['eslint'],
\   'typescript': ['eslint'],
\   'rust': ['analyzer'],
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'go': ['gofmt'],
\   'javascript': ['eslint'],
\   'javascript.jsx': ['eslint'],
\   'python': ['black', 'isort'],
\   'typescript': ['eslint'],
\   'rust': ['rustfmt'],
\}
" fix on save (disabled by default); to skip, use `:noa w`
let g:ale_fix_on_save = 0
let g:ale_set_loclist = 1
let g:ale_set_signs = 0
let g:ale_completion_enabled = 1
let g:ale_floating_preview = 1
let g:ale_hover_cursor = 0
let g:ale_rust_cargo_use_clippy = 1
let g:ale_yaml_yamllint_options='-d "{extends: relaxed, rules: {line-length: disable}}"'

" Ale Flake8
let g:ale_python_flake8_options = '--max-line-length=88 --extend-ignore=E203'



" set completeopt=menu,menuone,preview,noselect,noinsert
" let g:ale_disable_lsp = 1  " integration with coc
" to enable per-directory settings:
" let g:ale_pattern_options = {
" \  '/home/user/code/*': {'ale_fix_on_save': 1}
" \}

" CoC
" GoTo code navigation.
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
" nnoremap <silent> K :call ShowDocumentation()<CR>

" function! ShowDocumentation()
"   if CocAction('hasProvider', 'hover')
"     call CocActionAsync('doHover')
"   else
"     call feedkeys('K', 'in')
"   endif
" endfunction


" vim-gitgutter
let g:gitgutter_realtime=0  " don't update in realtime
let g:gitgutter_eager=0
" vim-gitgutter: fixes for solarized dark colorscheme
" highlight clear SignColumn
" autocmd ColorScheme * highlight clear SignColumn

" vim-signify
let g:signify_disable_by_default = 1
let g:signify_vcs_list = ['git', 'perforce']
" let g:signify_line_highlight = 1
" let g:signify_realtime = 1
" The following two autosave!
let g:signify_cursorhold_normal = 0
let g:signify_cursorhold_insert = 0

" Gutentags
let g:gutentags_ctags_tagfile = '.tags'

" Tagbar
let g:tagbar_autoclose = 1  " autoclose when selecting
let g:tagbar_sort = 0  " dont sort
let g:tagbar_autoshowtag = 1
let g:tagbar_left = 0
"let g:tagbar_vertical = 20

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
"let g:airline#extensions#tagbar#enabled = 0
"let g:airline_theme='oceanicnext'
" let g:lightline = {
"     \ 'colorscheme': 'oceanicnext',
"     \ 'active': {
"     \   'left': [ [ 'mode', 'paste' ],
"     \             [ 'readonly', 'filename', 'modified' ] ],
"     \   'right': [ [ 'lineinfo' ],
"     \              [ 'percent' ],
"     \              [ 'gitbranch', 'fileformat', 'fileencoding', 'filetype' ] ]
"     \ },
"     \ 'component_function': {
"     \   'gitbranch': 'fugitive#head'
"     \ },
"     \ }

" Perforce
"let g:perforce_auto_source_dirs = ['~/Perforce']
"let g:perforce_debug = 1

if !empty(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif
