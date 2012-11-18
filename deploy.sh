#!/usr/bin/env bash

CP="cp -R"

FILES=(
	"_vim/"
	"_vimrc"
	"_gvimrc"
	"_gitconfig"
	"_screenrc")

DESTFILES=(
	".vim/"
	".vimrc"
	".gvimrc"
	".gitconfig"
	".screenrc")

echo "Deploying '${FILES[@]}' to home directory."

for f in "${!FILES[@]}" # iterate index, not values
do
	DESTFILE="$HOME/${DESTFILES[$f]}"
	
	# check if destination is a folder, and already exists
	# cp -i will ask for overwrite automatically for files
	if [[ -d "$DESTFILE" && -e "$DESTFILE" ]]
	then
		read -p "overwrite directory $DESTFILE}? (y/n [n]) "
		if [[ "$REPLY" == "y" || "$REPLY" == "Y" ]]
		then
			cp -r "${FILES[$f]}" "$DESTFILE}"
		else
			echo "not overwritten"
		fi
	else
		cp -i "${FILES[$f]}" "$DESTFILE"
	fi
done