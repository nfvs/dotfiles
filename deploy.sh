#!/usr/bin/env bash

CP="cp -R"

FILES=(
	"_vim"
	"_vimrc"
	"_gvimrc"
	"_gitconfig"
	"_screenrc")

DESTFILES=(
	".vim"
	".vimrc"
	".gvimrc"
	".gitconfig"
	".screenrc")

echo "Deploying '${DESTFILES[@]}' to home directory."

for f in "${!FILES[@]}" # iterate index, not values
do

	SRCFILE="${PWD}/${FILES[$f]}"
	DESTFILE="$HOME/${DESTFILES[$f]}"
	
	if [[ -h "$DESTFILE" || -e "$DESTFILE" ]]
	then
		read -p "overwrite file $DESTFILE? (y/n [n]) "
		if [[ "$REPLY" == "y" || "$REPLY" == "Y" ]]
		then
			ln -sf "$SRCFILE" "$DESTFILE"
		else
			echo "not overwritten"
		fi

	else
		ln -s "$SRCFILE" "$DESTFILE"
	fi
	
done
