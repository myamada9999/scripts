#!/bin/bash

FILE=$1
# Remove *.enc
FILE_OUT=`echo ${FILE%.*}`

if ! [ -f $FILE ]; then
    echo "$FILE is not found."
    exit 1
fi

openssl enc -d -aes-256-cbc -salt -in $FILE -out $FILE_OUT

exit 0
