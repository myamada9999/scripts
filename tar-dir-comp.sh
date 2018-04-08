#!/bin/bash

DIR=`basename $1`

#FORMAT="gz"
FORMAT="bz2"
#FORMAT="xz"
#FORMAT="tar"

if ! [ -d $DIR ]; then
    echo "$DIR is not found."
    exit 1
fi

WORK_DIR=`mktemp -d`
mkdir -p $WORK_DIR

#rm -f $tmpnam
#mkdir "$tmpnam"

case $FORMAT in
    gz)     tar -zcvf $WORK_DIR/$DIR.tar.gz $DIR ;;
    bz2)    tar -jcvf ${WORK_DIR}/${DIR}.tar.bz2 $DIR ;;
    xz)     tar -Jcvf $WORK_DIR/$DIR.tar.xz $DIR ;;
    tar)    tar -cvf $WORK_DIR/$DIR.tar $DIR ;;
    *)      echo "FORMAT is malform." && exit 1;;
esac

mv ${WORK_DIR}/${DIR}.tar.bz2  ./
rm -r $WORK_DIR

exit 0
