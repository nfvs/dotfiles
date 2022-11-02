# Skip if oh-my-zsh hasn't been installed yet
if [ ! -d "$HOME/.oh-my-zsh" ] ; then
  return
fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

DEFAULT_USER=`whoami`

# Enable in `~/.localrc`
# plugins=(
#     docker
#     git
#     pip
#     rust
#     tmux
# )

# if [[ "$OSTYPE" == "linux-gnu" ]]; then
#     echo "Linux...";
# fi

source $ZSH/oh-my-zsh.sh
