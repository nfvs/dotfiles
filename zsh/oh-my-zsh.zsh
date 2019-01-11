# Skip if oh-my-zsh hasn't been installed yet
if [ ! -d "$HOME/.oh-my-zsh" ] ; then
  return
fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

DEFAULT_USER=`whoami`

plugins=(
	git
	osx
	brew
	node
	npm
	python
	tmux
	docker
	pip
	# virtualenv
	# virtualenvwrapper
	# ruby
	# rvm
	# rails
	# bundler
)

source $ZSH/oh-my-zsh.sh
