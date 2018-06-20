#!/bin/bash

GITCONFIG="${HOME}/.gitconfig"
GITCONFIG_OLD="${HOME}/.gitconfig.old"
GITCONFIG_PROXY="${HOME}/.gitconfig.proxy"

if [ ! -f ${GITCONFIG_PROXY} ]; then
	echo "ERROR: ${HOME}/.gitconfig.proxy is not found."
	exit 1
fi

if [ -f  ${GITCONFIG} ]; then
	cp ${GITCONFIG} ${GITCONFIG_OLD}
fi

echo "INFO: replace ${HOME}/.gitconfig as .gitconfig.proxy"
cp ${GITCONFIG_PROXY} ${GITCONFIG}

exit 0
