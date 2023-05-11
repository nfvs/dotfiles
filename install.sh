#!/usr/bin/env bash


set -e

cd "$(dirname "$0")"
DOTFILES_ROOT=$HOME/.dotfiles
HOME=~

# Create link to $HOME/.dotfiles
if [[ ! -h "$DOTFILES_ROOT" ]]; then
  ln -sf "$(pwd -P)" "$DOTFILES_ROOT"
fi

# shellcheck source=bash/functions.sh
source bash/functions.sh

link_file () {
  local src=$1 dst=$2

  local overwrite= backup="" skip=""
  local action=""

  if [ -f "$dst" ] || [ -d "$dst" ] || [ -L "$dst" ]
  then
    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
    then
      local currentSrc="$(readlink "$dst")"

      if [ "$currentSrc" == "$src" ]
      then
        skip=true;
      else
        echo_user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -rn 1 action

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

    # _<filename> -> .<filename>
    for src in $(find -H "$DOTFILES_ROOT" -maxdepth 1 -name '_*' -not -name '_*.example')
    do
        dst="$HOME/.$(basename "${src##*_}")"
        link_file "$src" "$dst"
    done

    # copy example files if they don't exist
    # eg. `_gitconfig.local.example` -> `~/.gitconfig.local`
    for src in $(find -H "$DOTFILES_ROOT" -maxdepth 1 -name '_*.example')
    do
        dst="$(basename "${src%.example}")"
        dst="${dst##*_}"
        dst="$HOME/.$dst"

        if [ ! -f "$dst" ]; then
            mv "$src" "$dst"
            echo_success "moved $src to $dst"
        else
            echo_success "skipped $dst"
        fi
    done

    # ~/.ssh/* files
    mkdir -p "$HOME/.ssh"
    link_file "$DOTFILES_ROOT/ssh_config" "$HOME/.ssh/config"
    link_file "$DOTFILES_ROOT/ssh_rc" "$HOME/.ssh/rc"

    # Fish
    mkdir -p "$HOME/.config/fish"
    link_file "$DOTFILES_ROOT/config.fish" "$HOME/.config/fish"
}

install_oh_my_zsh () {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo_info "Installing Oh-My-ZSH"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"  "" --unattended --keep-zshrc
    else
        echo_info "Oh-My-ZSH already installed"
    fi
}


if [[ "$OSTYPE" == "linux-gnu" ]]; then
    echo_info "Linux"
    
    install_oh_my_zsh

    # if command -v apt-get &> /dev/null; then
    #   sudo apt-get install -y curl git zsh tmux
    # fi
    # bash -c "$(curl -fsSL https://raw.githubusercontent.com/denysdovhan/oceanic-next-gnome-terminal/master/oceanic-next.bash)"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo_info "MacOS"
    # First things first
    xcode-select -p > /dev/null || xcode-select --install;
    
    # install brew
    if ! command -v brew &> /dev/null; then
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    
    brew bundle

    install_oh_my_zsh
fi


# ... then the others
# find . -mindepth 2 -name install.sh | grep -v 'homebrew' | while read installer ; do
# 	echo_info "› Installing ${installer}"
# 	sh -c "${installer}" < /dev/tty
# done


install_dotfiles
