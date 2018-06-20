#!/bin/bash

rsync -av $1/ $2/

# if you want to check checksum, then run -avc
# rsync -av $1/ $2/


exit 0
