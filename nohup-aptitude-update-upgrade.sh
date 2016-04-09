#!/bin/sh

nohup sudo aptitude update
mv nohup.out aptitude-update.log
nohup sudo aptitude -y upgrade
mv nohup.out aptitude-upgrade.log

exit 0
