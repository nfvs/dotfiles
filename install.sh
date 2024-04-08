#!/bin/bash


set -e

cd "$(dirname "$0")"
DOTFILES_ROOT=$HOME/.dotfiles
HOME=~

# Create link to $HOME/.dotfiles
if [[ ! -h "$DOTFILES_ROOT" ]]; then
  ln -sf "$(pwd -P)" "$DOTFILES_ROOT"
fi

echo_info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

echo_user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

echo_success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

echo_fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
}


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
    for src in $(find -H "$DOTFILES_ROOT" -maxdepth 1 -name '_*' -not -name '_*.example' -not -name '_config')
    do
        dst="$HOME/.$(basename "${src##*_}")"
        link_file "$src" "$dst"
    done

    # _config/<tool>/* -> ~/.config/<tool>/*
    for subdir in $(find -H "$DOTFILES_ROOT/_config" -mindepth 1 -maxdepth 1 -type d)
    do
      subdir="${subdir##*/}"
      mkdir -p "$HOME/.config/$subdir"
      for src in $(find -H "$DOTFILES_ROOT/_config/$subdir" -mindepth 1 -maxdepth 1)
      do
        filename=${src##*/}
        link_file "$src" "$HOME/.config/$subdir/$filename"
      done
    done

    # copy example files if they don't exist
    # eg. `_gitconfig.local.example` -> `~/.gitconfig.local`
    for src in $(find -H "$DOTFILES_ROOT" -maxdepth 1 -name '_*.example')
    do
        dst="$(basename "${src%.example}")"
        dst="${dst##*_}"
        dst="$HOME/.$dst"

        if [ ! -f "$dst" ]; then
            mv --backup=existing "$src" "$dst"
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
    link_file "$DOTFILES_ROOT/fish_config" "$HOME/.config/fish/config.fish"
    link_file "$DOTFILES_ROOT/fish_conf.d" "$HOME/.config/fish/conf.d"
    link_file "$DOTFILES_ROOT/fish_completions" "$HOME/.config/fish/completions"

    # Neovim
    mkdir -p "$HOME/.config/nvim"
    mkdir -p "$HOME/.config/nvim/after"
    mkdir -p "$HOME/.config/nvim/site/autoload"
    link_file "$DOTFILES_ROOT/_config/nvim/nvim_init.vim" "$HOME/.config/nvim/init.vim"
    link_file "$DOTFILES_ROOT/_vim/after/ftplugin" "$HOME/.config/nvim/after/ftplugin"

    # Zellij
    mkdir -p "$HOME/.config/zellij"
    link_file "$DOTFILES_ROOT/zellij/config.kdl" "$HOME/.config/zellij/config.kdl"
}

install_oh_my_zsh () {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo_info "Installing Oh-My-ZSH"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"  "" --unattended --keep-zshrc
    else
        echo_info "Oh-My-ZSH already installed"
    fi
}

install_dotfiles

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    echo_info "Linux"

    install_oh_my_zsh

    # Install ZSH Pure prompt
    if [ ! -d "$HOME/.zsh-pure" ]; then
        git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh-pure"
    fi

    # if command -v apt-get &> /dev/null; then
    #   sudo apt-get install -y curl git zsh tmux
    # fi
    # bash -c "$(curl -fsSL https://raw.githubusercontent.com/denysdovhan/oceanic-next-gnome-terminal/master/oceanic-next.bash)"

    # Vim-Plug
    curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    link_file "$HOME/.vim/autoload/plug.vim" "$HOME/.config/nvim/site/autoload/plug.vim"

    # FZF
    git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
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


