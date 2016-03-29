#!/bin/bash

RECIPES=$1

nohup bash -c "bitbake -c cleanall $RECIPES;bitbake $RECIPES"
mv nohup.out bitbake.log

exit 0
