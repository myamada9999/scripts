#!/bin/sh

MAIL_ADDRESS="masahiro9999@gmail.com"

function abort
{
	echo "ERROR: $@" 1>&2
	exit 1
}

# Check git, vim command
[ ! `which git` ] && abort "git command not found."
[ ! `which vim` ] && abort "vim command not found."

git config --global push.default matching
git config --global user.name 'Masahiro Yamada'
git config --global user.email $MAIL_ADDRESS
git config --global core.editor 'vim'

exit 0
