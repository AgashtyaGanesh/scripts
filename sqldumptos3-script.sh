#!/bin/bash
#secify the name of the database that you want to backup

# Database credentials
USER="$password"
#PASSWORD="password"
HOST="localhost"
DB_NAME="db-name"

#Backup_Directory_Locations
BACKUPROOT="/home/ubuntu/backup/mysqldump/"
TSTAMP=$(date +"%y-%b-%d-%H-%M-%S")
S3BUCKET="s3://bucket-name"
#LOG_ROOT="logs/dump.log"

#mysqldump  -h <HOST>  -u <USER>  --database <DB_NAME>  -p"password" > $BACKUPROOT/$DB_NAME-$TSTAMP.sql

#or

mysqldump -h$HOST -u$USER $DB_NAME | gzip -9 > $BACKUPROOT/$DB_NAME-$TSTAMP.sql.gz

if [ $? -ne 0 ]
 then
 mkdir /tmp/$TSTAMP
 s3cmd put -r /tmp/$TSTAMP $S3BUCKET/
 s3cmd sync -r $BACKUPROOT/ $S3BUCKET/$TSTAMP/
 rm -rf $BACKUPROOT/*
else
 s3cmd sync -r $BACKUPROOT/ $S3BUCKET/$TSTAMP/
 rm -rf $BACKUPROOT/*
fi
