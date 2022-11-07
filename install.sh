#!/usr/bin/env bash

set -e

cd "$(dirname "$0")"
DOTFILES_ROOT=$HOME/.dotfiles
HOME=~

# Create link to $HOME/.dotfiles
if [[ ! -h "$DOTFILES_ROOT" ]]; then
  ln -sf $(pwd -P) "$DOTFILES_ROOT"
fi

source $DOTFILES_ROOT/bash/functions.sh

link_file () {
  local src=$1 dst=$2

  local overwrite= backup= skip=
  local action=

  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
  then
    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
    then
      local currentSrc="$(readlink $dst)"

      if [ "$currentSrc" == "$src" ]
      then
        skip=true;
      else
        echo_user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac
      fi
    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]
    then
      rm -rf "$dst"
      echo_success "removed $dst"
    fi

    if [ "$backup" == "true" ]
    then
      mv "$dst" "${dst}.backup"
      echo_success "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]
    then
      echo_success "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    ln -s "$1" "$2"
    echo_success "linked $1 to $2"
  fi
}


install_dotfiles () {
  echo_info "installing dotfiles"

  local overwrite_all=false backup_all=false skip_all=false

  # _<fileaname> -> .<filename>
  for src in $(find -H "$DOTFILES_ROOT" -maxdepth 2 -name '_*' -not -path '*.git*')
  do
    dst="$HOME/.$(basename "${src##*_}")"
    link_file "$src" "$dst"
  done
}


if [[ "$OSTYPE" == "linux-gnu" ]]; then
    echo "Linux..."
    if command -v apt-get &> /dev/null; then
      sudo apt-get install -y curl git zsh tmux
    fi
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/denysdovhan/oceanic-next-gnome-terminal/master/oceanic-next.bash)"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "MacOS..."
    # First things first
    xcode-select -p || xcode-select --install;

    # Run installers: first homebrew...
    installer="./homebrew/install.sh"
    echo_info "› Installing ${installer}"
    sh -c "${installer}" < /dev/tty
fi


# ... then the others
find . -mindepth 2 -name install.sh | grep -v 'homebrew' | while read installer ; do
	echo_info "› Installing ${installer}"
	sh -c "${installer}" < /dev/tty
done


install_dotfiles
