#!/bin/bash

CURRENT_DIR=`pwd`
WORK_DIR=`mktemp -d`
ARCH="x86"
CROSS_COMPILE_ENVIRONMENT=""
CROSS_COMPILE=""
OUTPUT_DIR=""

function abort
{
	echo "ERROR: $@" 1>&2
	exit 1
}

function warn
{
	echo "ERROR: $@" 1>&2
}

while getopts "d:" flag; do
    case $flag in
        \?) OPT_ERROR=1; break;;
        d) OUTPUT_DIR="$OPTARG";;
    esac
done
shift $(( $OPTIND - 1 ))
[ $OPT_ERROR ] && abort "usage: $0 [-d output_directory]"

[ -f ./Makefile ] || abort "Makefile is not found."
[ -f ./.config ] || abort ".config is not found."
[ -d $WORK_DIR ] || abort "$WORK_DIR is not found."
if [ ! -z $OUTPUT_DIR ]; then
 [ -d $OUTPUT_DIR ] || abort "$OUTPUT_DIR is not found."
fi

# Get kernel version
VERSION=`cat Makefile | grep "^VERSION = " | cut -d "=" -f 2`
PATCHLEVEL=`cat Makefile | grep "^PATCHLEVEL = " | cut -d "=" -f 2`
SUBLEVEL=`cat Makefile | grep "^SUBLEVEL = " | cut -d "=" -f 2`
EXTRAVERSION=`cat Makefile | grep "^EXTRAVERSION = " | cut -d "=" -f 2`
[ -f ./localversion-rt ] && LOCALVERSION=`cat ./localversion-rt`

# Remove extra spaces
VERSION=`echo $VERSION`
PATCHLEVEL=`echo $PATCHLEVEL`
SUBLEVEL=`echo $SUBLEVEL`
EXTRAVERSION=`echo $EXTRAVERSION`
[ ! -z $LOCALVERSION ] && LOCALVERSION=`echo $LOCALVERSION`

KERNEL_VERSION=$VERSION"."$PATCHLEVEL"."$SUBLEVEL$EXTRAVERSION
[ ! -z $LOCALVERSION ] && KERNEL_VERSION=$KERNEL_VERSION$LOCALVERSION

mkdir $WORK_DIR/boot
mkdir $WORK_DIR/lib
mkdir $WORK_DIR/lib/modules

# run make and make install
if [ ! -z $CROSS_COMPILE_ENVIRONMENT ]; then
    sudo bash -c " \
                  source $CROSS_COMPILE_ENVIRONMENT; \
                  ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE make menuconfig || abort 'Menuconfig failed'; \
                  ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE make -j8 || abort 'Compile failed'; \
                  ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE make install INSTALL_PATH=$WORK_DIR/boot || abort  'Install failed'; \
                  ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE make modules_install INSTALL_MOD_PATH=$WORK_DIR || abort 'Module install failed'; \
                 "
else
    sudo bash -c " \
                  make menuconfig || abort 'Menuconfig failed'; \
                  make -j8 || abort 'Compile failed'; \
                  make install INSTALL_PATH=$WORK_DIR/boot || abort 'Install failed'; \
                  make modules_install INSTALL_MOD_PATH=$WORK_DIR || abort 'Module install failed'; \
                 "
fi

# Rename a temporary directory to output directory
if [ -z $OUTPUT_DIR ]; then
    [ -d "/tmp/"$KERNLE_VERSION".old" ] && sudo rm -rf "/tmp/"$KERNEL_VERSION".old"
    [ -d "/tmp/"$KERNLE_VERSION ] && sudo mv "/tmp/"$KERNEL_VERSION "/tmp/"$KERNEL_VERSION".old"
    sudo mv $WORK_DIR "/tmp/"$KERNEL_VERSION
else
    [ -d $OUTPUT_DIR$KERNLE_VERSION".old" ] && sudo rm -rf $OUTPUT_DIR$KERNEL_VERSION".old"
    [ -d $OUTPUT_DIR$KERNLE_VERSION ] && sudo mv $OUTPUT_DIR$KERNEL_VERSION $OUTPUT_DIR$KERNEL_VERSION".old"
    sudo mv $WORK_DIR $OUTPUT_DIR$KERNEL_VERSION
fi

exit 0
