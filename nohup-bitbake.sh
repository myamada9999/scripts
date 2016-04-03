#!/bin/bash

function abort
{
	echo "ERROR: $@" 1>&2
	rm -rf $WORK_DIR
	exit 1
}

CORE_IMAGE="core-image-base"
SEND_MAIL=0

while getopts "bmtn" flag; do
    case $flag in
        \?) OPT_ERROR=1; break;;
        b) CORE_IMAGE="core-image-base";;
        m) CORE_IMAGE="core-image-minimal";;
        t) TOOLCHAIN="meta-toolchain";;
        n) SEND_MAIL=1;;
    esac
done
shift $(( $OPTIND - 1 ))
[ $OPT_ERROR ] && abort "usage: $0 [-d output_directory]"

[ `which send-mail.sh` ] || abort "send-mail.sh is not found."
nohup bash -c "bitbake $CORE_IMAGE"
mv nohup.out $CORE_IMAGE.log
if [ ! -z $TOOLCHAIN ]; then
    nohup bash -c "bitbake $TOOLCHAIN"
    mv nohup.out $TOOLCHAIN.log
fi
if [ $SEND_MAIL == 1 ]; then
    send-mail.sh "@mail address" "bitbake finished." "`tail -n 50 $CORE_IMAGE.log`"
fi

exit 0
