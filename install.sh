#!/usr/bin/env sh

# set -e

cd "$(dirname "$0")"
DOTFILES_ROOT=$(pwd -P)
HOME=~

ln -sfh "$DOTFILES_ROOT" $HOME/.dotfiles

source $DOTFILES_ROOT/zsh/functions.zsh

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

  # _<fileanme> -> .<filename>
  for src in $(find -H "$DOTFILES_ROOT" -maxdepth 2 -name '_*' -not -path '*.git*')
  do
    dst="$HOME/.$(basename "${src##*_}")"
    # echo_info "LINKING $src $dst"
    link_file "$src" "$dst"
  done
}


# First things first
xcode-select -p || xcode-select --install;

# Run installers: first homebrew...
installer="./homebrew/install.sh"
echo_info "› Installing ${installer}"
sh -c "${installer}" < /dev/tty

# ... then the others
find . -name install.sh -mindepth 2 | grep -v 'homebrew' | while read installer ; do
	echo_info "› Installing ${installer}"
	sh -c "${installer}" < /dev/tty
done


install_dotfiles