#!/bin/sh
#
# An example hook script to verify what is about to be committed.
# Called by "git commit" with no arguments.  The hook should
# exit with non-zero status after issuing an appropriate message if
# it wants to stop the commit.
#
# To enable this hook, rename this file to "pre-commit".

if git rev-parse --verify HEAD >/dev/null 2>&1
then
	against=HEAD
else
	# Initial commit: diff against an empty tree object
	against=4b825dc642cb6eb9a060e54bf8d69288fbee4904
fi

# Redirect output to stderr.
exec 1>&2

SFTP_EXISTS=$(git diff --cached --name-status | grep "SFTP.sublime-settings")
NO_LICENSE=$(grep -r '^[[:space:]]*"product_key":[[:space:]]*".*"[,]\?' * --include="SFTP.sublime-settings")
# Use git diff-index to check for whitespace errors
echo "pre-commit: Testing for licenses..."
if [[ -n $SFTP_EXISTS ]] && [[ -n $NO_LICENSE ]]
then
    echo "pre-commit: Aborting! Please remove SFTP license!"
    exit 1
else
    echo "pre-commit: No errors."
    exit 0
fi