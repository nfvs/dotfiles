set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

if filereadable(expand("~/.config/nvim/local.vim"))
  source ~/.config/nvim/local.vim
endif
