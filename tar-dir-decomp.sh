#!/bin/bash

FILE=$1

if ! [ -f $FILE ]; then
    echo "$FILE is not found."
    exit 1
fi

tar -xvf $FILE

exit 0
