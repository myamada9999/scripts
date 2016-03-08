#!/bin/bash

CURRENT_DIR=`pwd`
WORK_DIR=`mktemp -d`
ARCH="x86"
CROSS_COMPILE_ENVIRONMENT=""
CROSS_COMPILE=""

function abort
{
	echo "ERROR: $@" 1>&2
	exit 1
}

function warn
{
	echo "ERROR: $@" 1>&2
}

[ -f ./Makefile ] || abort "Makefile is not found."
[ -f ./.config ] || abort ".config is not found."
[ -d $WORK_DIR ] || abort "$WORK_DIR is not found."

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
if [ ! -z $LOCALVERSION ]; then
    LOCALVERSION=`echo $LOCALVERSION`
fi

KERNEL_VERSION=$VERSION"."$PATCHLEVEL"."$SUBLEVEL$EXTRAVERSION
if [ ! -z $LOCALVERSION ]; then
    KERNEL_VERSION=$KERNEL_VERSION$LOCALVERSION
fi

echo $KERNEL_VERSION
exit 0

mkdir $WORK_DIR/boot
mkdir $WORK_DIR/lib
mkdir $WORK_DIR/lib/modules

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

[ -d "/tmp/"$KERNLE_VERSION".old" ] && sudo rm -rf "/tmp/"$KERNEL_VERSION".old"
[ -d "/tmp/"$KERNLE_VERSION ] && sudo mv "/tmp/"$KERNEL_VERSION "/tmp/"$KERNEL_VERSION".old"
sudo mv $WORK_DIR "/tmp/"$KERNEL_VERSION

exit 0
