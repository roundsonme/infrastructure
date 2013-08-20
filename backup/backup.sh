#!/bin/bash
 
# Todays date in ISO-8601 format:
DAY0=`date -I`

# Yesterdays date in ISO-8601 format:
DAY1=`date -I -d "1 day ago"`

# The source directory:
SRC="${1}"

#The target directory:
TRG="${2}/backup/$DAY0"

#The link destination directory:
LNK="${2}/backup/$DAY1"

#The rsync options:
OPT="-avh --delete --link-dest=$LNK"

#Execute the backup
rsync $OPT $SRC $TRG
