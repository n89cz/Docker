#!/bin/bash
#
# Export every docker containers to tar files
#

# The result is a TAR-file
# $1 must be ID of container - docker ps -a
#

# docker ps -a
# show all images - even stopped

CID_LIST=containers.tmp
DATE=`date +%Y-%m-%d`

if [ "$#" -ne 0 ]; then
    echo "Wrong usage"
    echo "Do not enter any parameter"
    exit 1
fi

# Check if $CID_LIST already exists - if yes delete it first
if [ -f $CID_LIST ]; then
    echo "Temporary file exists, removing..."
    rm $CID_LIST
    echo "Temporary file removed, continue..."
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
