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

echo "Images was installed to $WORK_DIR"

exit 0
