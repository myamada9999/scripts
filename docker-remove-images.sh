#!/bin/bash

function abort
{
	echo "ERROR: $@" 1>&2
	exit 1
}

IMAGE_ID=`sudo docker images -q`

if [ ! -z "$IMAGE_ID" ]; then
    for id in `echo $IMAGE_ID`
    do
        echo "remove docker image_id $id";
        sudo docker rmi $id || abort "docker rmi failed"
    done
fi

exit 0
