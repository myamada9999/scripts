#!/bin/sh

WORK_DIR=`mktemp -d`
FILE_NAME="done.txt"
ADDRESS="@adderss"
SUBJECT="@subject"
BODY="@body"

function usage
{
    echo "Usage: $0 ADDRESS SUBJECT BODY"
	rm -rf $WORK_DIR
    exit 1
}

[ $# != 3 ] && usage
ADDRESS=$1
SUBJECT=$2
BODY=$3

echo "From: $ADDRESS" >> $WORK_DIR/$FILE_NAME
echo "To: $ADDRESS"   >> $WORK_DIR/$FILE_NAME
echo "Subject: $SUBJECT"   >> $WORK_DIR/$FILE_NAME
echo "$BODY"               >> $WORK_DIR/$FILE_NAME

cat $WORK_DIR/$FILE_NAME | /usr/sbin/sendmail -i -t

rm -rf $WORK_DIR

exit 0
