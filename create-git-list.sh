#!/bin/bash

GIT_DIR=~/git-repositories
DIRS=`ls $GIT_DIR`
GIT_LIST="git-list.txt"
CURRENT_DIR=`pwd`

function abort
{
	echo "ERROR: $@" 1>&2
	exit 1
}

function warn
{
	echo "ERROR: $@" 1>&2
}

cd $GIT_DIR
for dir in `echo $DIRS`
do
    if [ ! -d $dir ]; then
        warn "$dir is not directory"
        continue
    fi
    if [ ! -d $dir/.git ]; then
        warn "$dir is not git directory"
        continue
    fi

    # Get git address
    URL=`cat $dir/.git/config | grep url | cut -d"=" -f2`
    echo $URL >> $CURRENT_DIR/$GIT_LIST
done
cd $CURRENT_DIR

exit 0
