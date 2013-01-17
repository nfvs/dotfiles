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

# Will hold full filenames
FILES_FULL=()
DESTFILES_FULL=()


# Destination directories relative to Home (~/)
SUBLIME_TEXT_2="sublime-text-2"
SUBLIME_TEXT_2_DEST_OSX="Library/Application Support/Sublime Text 2/Packages/User"
SUBLIME_TEXT_2_DEST_UNIX=".config/sublime-text-2/Packages/User"


# 1) Detect platform, choose correct SUBLIME_TEXT_2_DEST
echo ""
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
	echo "Platform detected: Linux"
	SUBLIME_TEXT_2_DEST=$SUBLIME_TEXT_2_DEST_UNIX
elif [[ "$unamestr" == 'Darwin' ]]; then
	echo "Platform detected: OS X"
   platform='osx'
   SUBLIME_TEXT_2_DEST=$SUBLIME_TEXT_2_DEST_OSX
else
	echo "Unknown platform, exiting."
	exit 0
fi

# 2) Print files to be deployed, prompt to continue
echo "Deploying:"
for f in "${!FILES[@]}" # iterate index, not values
do
	SRCFILE="${FILES[$f]}";
	DESTFILE="~/${DESTFILES[$f]}";
	echo -e "  ${SRCFILE}  \t --> ${DESTFILE}";
done
echo -e "  $SUBLIME_TEXT_2 --> ~/$SUBLIME_TEXT_2_DEST";
echo ""

read -p "Continue? (y/n [n]) "
if [[ "$REPLY" != "y" && "$REPLY" != "Y" ]]
then
	echo "Aborted."
	exit 0
fi

# 3) Build lists with full filenames
for f in "${!FILES[@]}" # iterate index, not values
do
	FILES_FULL+=("$PWD/${FILES[$f]}")
	DESTFILES_FULL+=("$HOME/${DESTFILES[$f]}")
done
FILES_FULL+=("$PWD/$SUBLIME_TEXT_2")
DESTFILES_FULL+=("$HOME/$SUBLIME_TEXT_2_DEST")

# 4) Deploy!
for f in "${!FILES_FULL[@]}" # iterate index, not values
do
	SRCFILE="${FILES_FULL[$f]}"
	DESTFILE="${DESTFILES_FULL[$f]}"
	if [[ -h "${DESTFILE}" || -e "${DESTFILE}" ]]
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