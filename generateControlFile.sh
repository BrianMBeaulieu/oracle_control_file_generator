#!/bin/sh
 
if [ -z $2 ]; then
	echo "This script generates a target control file".
	echo "Usage: $0 <SOURCE_DB_NAME> <TARGET_DB_NAME>"
	exit
fi

export ORACLE_SID=$1
export DEST_SID=$2

USER_DUMP_DIR=`$ORACLE_HOME/bin/sqlplus -s / as sysdba @_getUserDumpDest.sql` 
TRACEID=`$ORACLE_HOME/bin/sqlplus -s / as sysdba @_createControlFile.sql`

export DEST_FILE=$USER_DUMP_DIR/${ORACLE_SID}_control_file
export SOURCE_FILE=$USER_DUMP_DIR/${ORACLE_SID}_ora_${TRACEID}.trc 

mv $SOURCE_FILE $DEST_FILE
CONTROL_FILE=`perl _generateControlFile.pl $ORACLE_SID $DEST_SID $DEST_FILE`
cat $CONTROL_FILE