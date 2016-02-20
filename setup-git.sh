#!/bin/sh

MAIL_ADDRESS="masahiro9999@gmail.com"

git config --global push.default matching
git config --global user.name 'Masahiro Yamada'
git config --global user.email $MAIL_ADDRESS
git config --global core.editor 'vim'
