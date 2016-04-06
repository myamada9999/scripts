#!/bin/bash

function usage
{
    echo "Usage: $0 USER REPOSITORY"
	rm -rf $WORK_DIR
    exit 1
}

[ $# != 2 ] && usage
USER=$1
REPOSITORY=$2

git clone https://github.com/$1/$2

exit 0
