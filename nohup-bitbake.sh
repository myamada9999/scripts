#!/bin/bash

function abort
{
	echo "ERROR: $@" 1>&2
	rm -rf $WORK_DIR
	exit 1
}

CORE_IMAGE="core-image-base"

while getopts "bmt" flag; do
    case $flag in
        \?) OPT_ERROR=1; break;;
        b) CORE_IMAGE="core-image-base";;
        m) CORE_IMAGE="core-image-minimal";;
        t) TOOLCHAIN=1;;
    esac
done
shift $(( $OPTIND - 1 ))
[ $OPT_ERROR ] && abort "usage: $0 [-d output_directory]"

[ `which send-mail.sh` ] || abort "send-mail.sh is not found."
nohup bash -c "bitbake $CORE_IMAGE"
mv nohup.out $CORE_IMAGE.log
if [ $TOOLCHAIN ]; then
    nohup bash -c "bitbake meta-toolchain"
    mv nohup.out $CORE_IMAGE.log
fi
send-mail.sh "myamada9999@gmail.com" "bitbake finished." "`tail -n 50 nohup.out`"

exit 0
