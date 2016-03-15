#!/bin/bash

SQL_TEMPLATE="sqlite-drop-data-template.sql"
SQL="sqlite-drop-data.sql"
DB="tmp.db"
INPUT="input.txt"
OUTPUT="output.txt"
COUNT=3
AGGREGATE_FUNCTION=max

function abort
{
	echo "ERROR: $@" 1>&2
	exit 1
}

[ `which sqlite3` ] || abort "sqlite3 command is not found."
[ -f $SQL_TEMPLATE ] || abort "$SQL_TEMPLATE is not found."
[ -f $INPUT ] || abort "$INPUT file is not found."

# create sql script from template
[ -f $SQL ] && rm $SQL
cp $SQL_TEMPLATE $SQL
sed -i -e "s/INPUT/${INPUT}/g" $SQL
sed -i -e "s/OUTPUT/${OUTPUT}/g" $SQL
sed -i -e "s/COUNT/${COUNT}/g" $SQL
sed -i -e "s/AGGREGATE_FUNCTION/${AGGREGATE_FUNCTION}/g" $SQL

sqlite3 $DB < $SQL
rm $DB $SQL

exit 0
