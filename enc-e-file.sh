#!/bin/bash

FILE=$1

if ! [ -f $FILE ]; then
    echo "$FILE is not found."
    exit 1
fi

openssl enc -e -aes-256-cbc -salt -in $FILE -out $FILE.enc

exit 0
