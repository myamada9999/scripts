#!/bin/bash

GITCONFIG="${HOME}/.gitconfig"
GITCONFIG_OLD="${HOME}/.gitconfig.old"
GITCONFIG_NOPROXY="${HOME}/.gitconfig.noproxy"

if [ ! -f ${GITCONFIG_NOPROXY} ]; then
	echo "ERROR: ${HOME}/.gitconfig.noproxy is not found."
	exit 1
fi

if [ -f  ${GITCONFIG} ]; then
	cp ${GITCONFIG} ${GITCONFIG_OLD}
fi

echo "INFO: replace ${HOME}/.gitconfig as .gitconfig.noproxy"
cp ${GITCONFIG_NOPROXY} ${GITCONFIG}

exit 0
