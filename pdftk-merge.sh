#!/bin/bash

if [ ! `which pdftk` ]; then
	echo "ERROR: pdftk: Not found."
	echo "ERROR: Install pdftk package."
	exit 1
fi

pdftk *.pdf cat output output.pdf

exit 0
