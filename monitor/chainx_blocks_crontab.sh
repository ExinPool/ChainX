#!/bin/bash
#
# Copyright © 2019 ExinPool <robin@exin.one>
#
# Distributed under terms of the MIT license.
#
# Desc: ChainX node monitor crontab script.
# User: Robin@ExinPool
# Date: 2019-6-25
# Time: 16:29:30

nohup /usr/bin/python /data/ExinPool/ChainX/monitor/chainx_blocks.py VALIDATOR ws://127.0.0.1:${YOUR_PORT} &
nohup /usr/bin/python /data/ExinPool/ChainX/monitor/chainx_blocks.py BACKUP ws://127.0.0.1:${YOUR_PORT} &
nohup /usr/bin/python /data/ExinPool/ChainX/monitor/chainx_blocks.py SYNC wss://exinpool-chainx.872369.com &