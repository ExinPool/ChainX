#!/bin/bash
#
# Copyright © 2019 ExinPool <robin@exin.one>
#
# Distributed under terms of the MIT license.
#
# Desc: ChainX backup script.
# User: Robin@ExinPool
# Date: 2019-6-26
# Time: 12:00:18

CHAINX_DIR="/backup/chains"
BACKUP_TAG="chains"
BACKUP_DIR="/backup/data/chainx"
BACKUP_TIME=`date '+%Y%m%d%H%M%S'`
SLEEP_TIME=60

mkdir -p ${BACKUP_DIR}
process=`ps -ef | grep chainx | grep ${BACKUP_TAG} | grep -v grep | wc -l`

if [ $process -eq 1 ]
then
    echo "`date '+%Y-%m-%d %H:%M:%S'` `whoami` INFO ChainX backup node is running, then shutdown."

    # Shutdown ChainX node.
    cd ${CHAINX_DIR} && bash stop.sh
    process=`ps -ef | grep chainx | grep ${BACKUP_TAG} | grep -v grep | wc -l`

    if [ $process -eq 0 ]
    then
        echo "`date '+%Y-%m-%d %H:%M:%S'` `whoami` INFO ChainX backup node shutdown successfully."
        tar -cvzf chainx-backup-${BACKUP_TIME}.tgz data

        if [ $? -eq 0 ]
        then
            echo "`date '+%Y-%m-%d %H:%M:%S'` `whoami` INFO ChainX node backup successfully, then archive."
            sleep ${SLEEP_TIME}

            # Keep 3 days backup.
            find ${BACKUP_DIR} -mindepth 1 -mtime +3 -delete
            mv -v chainx-backup-${BACKUP_TIME}.tgz ${BACKUP_DIR}

            if [ $? -eq 0 ]
            then
                echo "`date '+%Y-%m-%d %H:%M:%S'` `whoami` INFO ChainX node backup successfully, then start ChainX node."
                # Startup ChainX node.
                cd ${CHAINX_DIR} && bash start.sh
                process=`ps -ef | grep chainx | grep ${BACKUP_TAG} | grep -v grep | wc -l`

                if [ $process -eq 1 ]
                then
                    echo "`date '+%Y-%m-%d %H:%M:%S'` `whoami` INFO ChainX node start successfully."
                else
                    echo "`date '+%Y-%m-%d %H:%M:%S'` `whoami` ERROR ChainX node start failed."
                fi
            else
                echo "`date '+%Y-%m-%d %H:%M:%S'` `whoami` ERROR ChainX node archive failed."
            fi
        else
            echo "`date '+%Y-%m-%d %H:%M:%S'` `whoami` ERROR ChainX node backup failed."
        fi
    else
        echo "`date '+%Y-%m-%d %H:%M:%S'` `whoami` ERROR ChainX backup node close failed."
    fi
else
    echo "`date '+%Y-%m-%d %H:%M:%S'` `whoami` ERROR ChainX backup node is not running."
fi