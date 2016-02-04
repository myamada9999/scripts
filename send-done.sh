#!/bin/sh

# Please set NOPASSWD to /usr/sbin/sendmail 
# in /etc/sudoers like below.
# ${USER} ALL=(ALL;ALL) NOPASSWD: /usr/sbin/sendmail

WORK_DIR=`mktemp -d`
FILE_NAME="done.txt"
MAIL_ADDRESS="hoge@xxx.co.jp"

echo "From: $MAIL_ADDRESS" >> $WORK_DIR/$FILE_NAME
echo "To: $MAIL_ADDRESS"   >> $WORK_DIR/$FILE_NAME
echo "Subject: DONE"       >> $WORK_DIR/$FILE_NAME
echo ""                    >> $WORK_DIR/$FILE_NAME

cat $WORK_DIR/$FILE_NAME | /usr/sbin/sendmail -i -t

rm -rf $WORK_DIR
