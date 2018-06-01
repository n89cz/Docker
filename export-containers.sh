#!/bin/bash
#
# Export every docker containers to tar files
#

CID_LIST=containers.tmp
DATE=`date +%Y-%m-%d`
LOG="export-containers.log"

if [ "$#" -ne 0 ]; then
    echo "Wrong usage" >> $LOG
    echo "Do not enter any parameter" >> $LOG
    exit 1
fi

# Check if $CID_LIST already exists - if yes delete it first
if [ -f $CID_LIST ]; then
    echo "Temporary file exists, removing..." >> $LOG
    rm $CID_LIST
    echo "Temporary file removed, continue..." >> $LOG
fi

docker ps -a | cut -d ' ' -f 1 | tail -n +2 >> $CID_LIST

mkdir -p /data/backups/$DATE

# here we backup every container which is present on $CID_LIST
while read CONTAINER
do
    docker export $CONTAINER > /data/backups/$DATE/$CONTAINER.tar
    echo $CONTAINER
done < $CID_LIST

rm $CID_LIST
exit 0
