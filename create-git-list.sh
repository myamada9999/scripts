#!/bin/bash

GIT_DIR=~/git-repositories
DIRS=`ls $GIT_DIR`
OUTPUT_FILE="git-list.txt"
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

while getopts "o:" flag; do
    case $flag in
        \?) OPT_ERROR=1; break;;
        o) OUTPUT_FILE="$OPTARG";;
    esac
done
shift $(( $OPTIND - 1 ))
[ $OPT_ERROR ] && abort "usage: $0 [-o output_file]"

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
    echo $URL >> $CURRENT_DIR/$OUTPUT_FILE
done
cd $CURRENT_DIR

exit 0
