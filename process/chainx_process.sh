#!/bin/bash
#
# Copyright © 2019 ExinPool <robin@exin.one>
#
# Distributed under terms of the MIT license.
#
# Desc: ChainX process monitor script.
# User: Robin@ExinPool
# Date: 2019-08-08
# Time: 18:41:18

# load the config library functions
source config.shlib

# load configuration
service="$(config_get SERVICE)"
process="$(config_get PROCESS)"
process_num="$(config_get PROCESS_NUM)"
process_num_var=`ps -ef | grep ${process} | grep config | grep -v grep | wc -l`
log_file="$(config_get LOG_FILE)"
webhook_url="$(config_get WEBHOOK_URL)"
access_token="$(config_get ACCESS_TOKEN)"

if [ ${process_num} -eq ${process_num_var} ]
then
    log="`date '+%Y-%m-%d %H:%M:%S'` `hostname` `whoami` INFO ${service} node process is normal."
    echo $log >> $log_file
else
    log="`date '+%Y-%m-%d %H:%M:%S'` `hostname` `whoami` ERROR ${service} node process is abnormal."
    echo $log >> $log_file
    success=`curl ${webhook_url}=${access_token} -XPOST -H 'Content-Type: application/json' -d '{"category":"PLAIN_TEXT","data":"'"$log"'"}' | awk -F',' '{print $1}' | awk -F':' '{print $2}'`
    if [ "$success" = "true" ]
    then
        log="`date '+%Y-%m-%d %H:%M:%S'` UTC `hostname` `whoami` INFO send mixin successfully."
        echo $log >> $log_file
    else
        log="`date '+%Y-%m-%d %H:%M:%S'` UTC `hostname` `whoami` INFO send mixin failed."
        echo $log >> $log_file
    fi
fi