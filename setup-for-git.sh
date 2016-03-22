#!/bin/bash

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
git config --global alias.ad 'add .'
git config --global alias.co 'commit -s'
git config --global alias.in 'commit -s --interactive'
git config --global alias.br 'branch -a'
git config --global alias.ch 'checkout -b'
git config --global alias.lo 'log'
git config --global alias.pu 'push origin'
git config --global alias.pl 'pull'
git config --global alias.ha 'reset --hard'
git config --global alias.so 'reset --soft'
git config --global alias.fo 'format-patch'

exit 0
