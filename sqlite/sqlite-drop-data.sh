#!/bin/bash

function abort
{
	echo "ERROR: $@" 1>&2
	exit 1
}

[ `which sqlite` ] || abort "sqlite command is not found."
[ -f sqlite-drop-data.sql ] || abort "sqlite-drop-data.sql is not found."

sqlite3 tmp.db < sqlite-drop-data.sql
rm tmp.db

exit 0
