#!/bin/bash

function abort
{
	echo "ERROR: $@" 1>&2
	exit 1
}

[ `which docker-remove-images.sh` ] || abort "docker-remove-images.sh is not found."
[ `which docker-remove-container.sh` ] || abort "docker-remove-images.sh is not found."
[ `which docker-stop-container.sh` ] || abort "docker-stop-images.sh is not found."

docker-stop-container.sh
docker-remove-container.sh
docker-remove-images.sh

exit 0
