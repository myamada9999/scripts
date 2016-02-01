#!/bin/sh

set -vx

USER=$1
GIT_REPOSITORIES=/home/${USER}/git-repositories
DIRS=`ls $GIT_REPOSITORIES`

# Check git command
[ ! `which git` ] && abort "git command not found."

for dir in `echo $DIRS`
do
	cd $GIT_REPOSITORIES/$dir;
	git pull
done

exit 0

function abort
{
	echo "ERROR: $@" 1>&2
	exit 1
}

function usage
{
    echo "Usage: $0 USER"
    exit 1
}
