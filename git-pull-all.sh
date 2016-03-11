#!/bin/bash

GIT_REPOSITORIES=~/git-repositories
DIRS=`ls $GIT_REPOSITORIES`

function abort
{
	echo "ERROR: $@" 1>&2
	exit 1
}

# Check git command
[ ! `which git` ] && abort "git command not found."

for dir in `echo $DIRS`
do
	cd $GIT_REPOSITORIES/$dir;
	git pull
done

exit 0
