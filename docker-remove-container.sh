#!/bin/bash

function abort
{
	echo "ERROR: $@" 1>&2
	exit 1
}

CONTAINER_ID=`sudo docker ps -q`

if [ ! -z "$CONTAINER_ID" ]; then
    for id in `echo $CONTAINER_ID`
    do
        echo "remove docker container_id $id"
        sudo docker rm $id || abort "docker rm failed"
    done
fi

exit 0
