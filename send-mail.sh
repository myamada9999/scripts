#!/bin/sh

WORK_DIR=`mktemp -d`
FILE_NAME="done.txt"
MAIL_ADDRESS="@adderss"
SUBJECT="@subject"
BODY="@body"

function usage
{
    echo "Usage: $0 SUBJECT BODY"
	rm -rf $WORK_DIR
    exit 1
}

[ $# != 2 ] && usage
SUBJECT=$1
BODY=$2

echo "From: $MAIL_ADDRESS" >> $WORK_DIR/$FILE_NAME
echo "To: $MAIL_ADDRESS"   >> $WORK_DIR/$FILE_NAME
echo "Subject: $SUBJECT"   >> $WORK_DIR/$FILE_NAME
echo "$BODY"               >> $WORK_DIR/$FILE_NAME

cat $WORK_DIR/$FILE_NAME | /usr/sbin/sendmail -i -t

rm -rf $WORK_DIR

exit 0
