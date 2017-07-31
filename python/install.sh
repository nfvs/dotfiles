cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)
HOME=~

pipsi install pew
pipsi install pipenv

# replace system python with homebrew's
ln -sf /usr/local/bin/python2 /usr/local/bin/python