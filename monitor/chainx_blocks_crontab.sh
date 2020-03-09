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

nohup /usr/bin/python /data/monitor/exinpool/ChainX/monitor/chainx_blocks.py &