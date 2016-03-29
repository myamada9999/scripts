#!/bin/bash

GIT_REPOSITORIES=~/git-repositories/

function abort
{
	echo "ERROR: $@" 1>&2
	exit 1
}

function usage
{
    echo "Usage: $0 [GIT_DIRECTORY]"
	rm -rf $WORK_DIR
    exit 1
}

[ $# -gt 1 ] && usage
[ $# -eq 1 ] && GIT_REPOSITORIES=$1

# Check git command
[ ! `which git` ] && abort "git command not found."

DIRS=`ls $GIT_REPOSITORIES`
echo $GIT_REPOSITORIES
echo $DIRS

for dir in `echo $DIRS`
do
    CURRENT_DIR=`pwd`
	cd $GIT_REPOSITORIES$dir;
	git pull
    cd $CURRENT_DIR
done

exit 0
