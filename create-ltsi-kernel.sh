#!/bin/bash

set -vx

WORK_DIR=`mktemp -d`
CURRENT_DIR=`pwd`
GIT_REPOSITORY="~/git-repositories"
LOCAL_GIT_SERVER=""
LINUX_STABLE_SEVER="git://git.kernel.org/pub/scm/linux/kernel/git/stable/"
LTSI_KERNEL_SERVER="http://git.linuxfoundation.org/"

# For example, v4.1.17
[ $# != 1 ] && usage
TAG_NAME=$1

# Set SERVER if user has a LOCAL_GIT_SERVER
if [ ! -z $LOCAL_GIT_SERVER ] then
	LINUX_STABLE_SEVER=$LOCAL_GIT_SERVER
	LTSI_KERNEL_SERVER=$LOCAL_GIT_SERVER
fi

# Prepare linux-stable and ltsi-kernel in $GIT_REPOSITORY
[ -d $GIT_REPOSITORY ] || abort "$GIT_REPOSITORY is not found."
cd $GIT_REPOSITORY
if [ -d "linux-stable" ] then
	git clone $LINUX_STABLE_SERVER"linux-stable.git" || abort "git clone failed."
else
	cd linux-stable; git pull; cd ../
fi
if [ -d "ltsi-kernel" ] then
	git clone $LTSI_KERNEL_SERVER"ltsi-kernel.git" || abort "git clone failed."
else
	cd ltsi-kernel; git pull; cd ../
fi

# Create ltsi kernel by generate_git
cd $WORKD_DIR
cp -rf $GIT_REPOSITORY/linux-stable ./
cp -rf $GIT_REPOSITORY/ltsi-kernel ./
cd ltsi-kernel
git checkout $TAG_NAME-ltsi || abort "git checkout failed."
cd ../linux-stable
git checkout $TAG || abort "git checkout failed."
../ltsi-kernel/scripts/generate_git || abort "generate_git failed."

# Move ltsi kernel source to a directory where user is
cd ../
mv linux-stable $CURRENT_DIR/linux-stable-$TAG-ltsi
cd $CURRENT_DIR
rm -rf $WORKD_DIR

exit 0

function abort
{
	echo "ERROR: $@" 1>&2
	rm -rf $WORKD_DIR
	cd $CURRENT_DIR
	exit 1
}

function usage
{
    echo "Usage: $0 TAG"
	echo "TAG is include v, EX: v4.1.17"
	rm -rf $WORKD_DIR
	cd $CURRENT_DIR
    exit 1
}
