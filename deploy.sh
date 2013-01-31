#!/usr/bin/env bash

CP="cp -R"

FILES=(
	"_vim"
	"_vimrc"
	"_gvimrc"
	"_gitconfig"
	"_hgrc"
	"_screenrc")

DESTFILES=(
	".vim"
	".vimrc"
	".gvimrc"
	".gitconfig"
	".hgrc"
	".screenrc")

# Will hold full filenames
FILES_FULL=()
DESTFILES_FULL=()


# Destination directories relative to Home (~/)
SUBLIME_TEXT_2_USER="sublime-text-2/User"
SUBLIME_TEXT_2_USER_DEST_OSX="Library/Application Support/Sublime Text 2/Packages/User"
SUBLIME_TEXT_2_USER_DEST_LINUX=".config/sublime-text-2/Packages/User"

SUBLIME_TEXT_2_DEFAULT_OSX="sublime-text-2/Default/Preferences (OSX).sublime-settings"
SUBLIME_TEXT_2_DEFAULT_OSX_DEST="Library/Application Support/Sublime Text 2/Packages/Default/Preferences (OSX).sublime-settings"
SUBLIME_TEXT_2_DEFAULT_LINUX="sublime-text-2/Default/Preferences (Linux).sublime-settings"
SUBLIME_TEXT_2_DEFAULT_LINUX_DEST="Library/Application Support/Sublime Text 2/Packages/Default/Preferences (Linux).sublime-settings"

# 1) Detect platform, choose correct SUBLIME_TEXT_2_USER_DEST,
# SUBLIME_TEXT_2_DEFAULT and SUBLIME_TEXT_2_DEFAULT_DEST
echo ""
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
	echo "Platform detected: Linux"
	SUBLIME_TEXT_2_USER_DEST=$SUBLIME_TEXT_2_USER_DEST_LINUX
	SUBLIME_TEXT_2_DEFAULT=$SUBLIME_TEXT_2_DEFAULT_LINUX
   	SUBLIME_TEXT_2_DEFAULT_DEST=$SUBLIME_TEXT_2_DEFAULT_LINUX_DEST
elif [[ "$unamestr" == 'Darwin' ]]; then
	echo "Platform detected: OS X"
   platform='osx'
   SUBLIME_TEXT_2_USER_DEST=$SUBLIME_TEXT_2_USER_DEST_OSX
   SUBLIME_TEXT_2_DEFAULT=$SUBLIME_TEXT_2_DEFAULT_OSX
   SUBLIME_TEXT_2_DEFAULT_DEST=$SUBLIME_TEXT_2_DEFAULT_OSX_DEST
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
	echo -e "  ${SRCFILE}  \t\t -->  ${DESTFILE}";
done
echo -e "  $SUBLIME_TEXT_2_USER \t -->  ~/$SUBLIME_TEXT_2_USER_DEST";
echo -e "  $SUBLIME_TEXT_2_DEFAULT --> ~/$SUBLIME_TEXT_2_DEFAULT_DEST";
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
FILES_FULL+=("$PWD/$SUBLIME_TEXT_2_USER")
DESTFILES_FULL+=("$HOME/$SUBLIME_TEXT_2_USER_DEST")
FILES_FULL+=("$PWD/$SUBLIME_TEXT_2_DEFAULT")
DESTFILES_FULL+=("$HOME/$SUBLIME_TEXT_2_DEFAULT_DEST")

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
			ln -sfn "$SRCFILE" "$DESTFILE"
		else
			echo "not overwritten"
		fi
	else
		ln -s "$SRCFILE" "$DESTFILE"
	fi
done
