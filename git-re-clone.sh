#!/bin/bash

WORK_DIR=`mktemp -d`

function abort
{
	echo "ERROR: $@" 1>&2
	rm -rf $WORK_DIR
	exit 1
}

function usage
{
    echo "Usage: $0 GIT_DIRECTORY"
	rm -rf $WORK_DIR
    exit 1
}

[ $# != 1 ] && usage
GIT_DIRECTORY=$1

[ -d $GIT_DIRECTORY ] || abort "$GIT_DIRECTORY not found."

URL=`cat $GIT_DIRECTORY/.git/config | grep url | cut -d"=" -f2`

mv $GIT_DIRECTORY $WORK_DIR/ || abort "cannot move $GIT_DIRECTORY"
git clone $URL || abort "To git clone $URL failed"
rm -rf $WORK_DIR || abort "To remove $WORK_DIR failed"

exit 0
