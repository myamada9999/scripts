#!/bin/bash

set -uevx

WORK_DIR=`mktemp -d`
CURRENT_DIR=`pwd`
GIT_REPOSITORY=~/git-repositories
LOCAL_GIT_SERVER=""
LINUX_STABLE_SERVER="git://git.kernel.org/pub/scm/linux/kernel/git/stable/"
LTSI_KERNEL_SERVER="http://git.linuxfoundation.org/"

function abort
{
	echo "ERROR: $@" 1>&2
	rm -rf $WORK_DIR
	cd $CURRENT_DIR
	exit 1
}

function usage
{
    echo "Usage: $0 TAG_NAME"
	echo "TAG_NAME is include v, EX: v4.1.17"
	rm -rf $WORK_DIR
	cd $CURRENT_DIR
    exit 1
}


# For example, v4.1.17
[ $# != 1 ] && usage
TAG_NAME=$1

# Set SERVER if user has a LOCAL_GIT_SERVER
if [ ! -z $LOCAL_GIT_SERVER ]; then
	LINUX_STABLE_SERVER=$LOCAL_GIT_SERVER
	LTSI_KERNEL_SERVER=$LOCAL_GIT_SERVER
fi

# Prepare linux-stable and ltsi-kernel in $GIT_REPOSITORY
[ -d $GIT_REPOSITORY ] || abort "$GIT_REPOSITORY is not found."
cd $GIT_REPOSITORY
if [ -d "$GIT_REPOSITORY/linux-stable" ]; then
	cd linux-stable; git pull; cd ../
else
	git clone $LINUX_STABLE_SERVER"linux-stable.git" || abort "git clone failed."
fi
if [ -d "$GIT_REPOSITORY/ltsi-kernel" ]; then
	cd ltsi-kernel; git pull; cd ../
else
	git clone $LTSI_KERNEL_SERVER"ltsi-kernel.git" || abort "git clone failed."
fi

# Create ltsi kernel by generate_git
cd $WORK_DIR
cp -rf $GIT_REPOSITORY/linux-stable ./
cp -rf $GIT_REPOSITORY/ltsi-kernel ./
cd ltsi-kernel
git checkout $TAG_NAME-ltsi || abort "git checkout failed."
cd ../linux-stable
git checkout $TAG_NAME || abort "git checkout failed."
../ltsi-kernel/scripts/generate_git || abort "generate_git failed."

# Move ltsi kernel source to a directory where user is
cd ../
mv linux-stable $CURRENT_DIR/linux-stable-$TAG_NAME-ltsi
cd $CURRENT_DIR
rm -rf $WORK_DIR

exit 0
