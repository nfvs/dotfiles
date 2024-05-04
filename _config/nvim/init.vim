set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
if filereadable(expand("~/.vimrc"))
    source ~/.vimrc
endif

" if filereadable(expand("~/.config/nvim/local.vim"))
"   source ~/.config/nvim/local.vim
" endif
