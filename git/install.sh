#!/usr/bin/env sh

cd "$(dirname "$0")/.."
HOME=~
DOTFILES_ROOT=$(pwd -P)

source $DOTFILES_ROOT/zsh/functions.zsh

setup_gitconfig () {
    echo_info "setup gitconfig"

    setup_local_gitconfig=0

    if [ -f $DOTFILES_ROOT/git/_gitconfig.local ] ;
    then
        printf ""
        # read -p "gitconfig setup already found, reset? (y/n) " -n 1 REPLY
        # echo "";
        # if [[ $REPLY =~ ^[Yy]$ ]]; then
        #     setup_local_gitconfig=1;
        # fi
    else
        setup_local_gitconfig=1;
    fi


    if [ $setup_local_gitconfig == 1 ] ;
    then
        git_credential='cache'
        if [ "$(uname -s)" == "Darwin" ]
        then
            git_credential='osxkeychain'
        fi
        printf " - What is your github author name? "
        read -e git_authorname
        printf " - What is your github author email? "
        read -e git_authoremail

        sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" $DOTFILES_ROOT/git/gitconfig.local.example > $DOTFILES_ROOT/git/_gitconfig.local
    fi

    echo_success "gitconfig"
}

setup_gitconfig
ln -sfh "$DOTFILES_ROOT/git/_gitconfig" $HOME/.gitconfig
ln -sfh "$DOTFILES_ROOT/git/_gitconfig.local" $HOME/.gitconfig.local
echo_success "git setup done"