#!/bin/bash

function abort
{
	echo "ERROR: $@" 1>&2
	rm -rf $WORK_DIR
	exit 1
}

[ `which send-mail.sh` ] || abort "send-mail.sh is not found."
nohup bash -c "bitbake core-image-base; bitbake meta-toolchain"
send-mail.sh "bitbake finished." "`tail -n 50 nohup.out`"

exit 0
