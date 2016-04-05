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
    echo "Usage: $0 GIT_DIR"
	rm -rf $WORK_DIR
    exit 1
}

[ $# != 1 ] && usage
GIT_DIR=$1

# check git directory
[ -d $GIT_DIR ] || abort "$GIT_DIR not found."

# Get git address
URL=`cat $GIT_DIR/.git/config | grep url | cut -d"=" -f2`

mv $GIT_DIR $WORK_DIR/ || abort "cannot move $GIT_DIR"
CURRENT_DIR=`pwd`
cd $WORK_DIR
rm -rf $GIT_DIR
git clone $URL || abort "To git clone $URL failed"
GIT_DIR_ORIG=`ls`
mv $GIT_DIR_ORIG $CURRENT_DIR/$GIT_DIR
cd $CURRENT_DIR
rm -rf $WORK_DIR || abort "To remove $WORK_DIR failed"

exit 0
