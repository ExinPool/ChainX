#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Copyright © 2019 ExinPool <robin@exin.one>
#
# Distributed under terms of the MIT license.
#
# Desc: ChainX node monitor script, alarm by QQ Mail.
# User: Robin@ExinPool
# Date: 2019-6-25
# Time: 16:29:30

import socket
import json
import sys
import logging
import smtplib
from email.mime.text import MIMEText
from email.utils import formataddr
from websocket import create_connection, WebSocket

NODE_NAME = "ExinPool"
NODE_TAG = sys.argv[1]
LOCAL_NODE = sys.argv[2]
REMOTE_NODE_1 = "wss://ws.chainxtools.com"
REMOTE_NODE_2 = "wss://chainx.maiziqianbao.net/ws"

def log_config():
    logging.basicConfig(filename="chainx_blocks.log",
                                filemode='a',
                                format='%(asctime)s.%(msecs)d %(name)s %(levelname)s %(message)s',
                                datefmt='%Y-%m-%d %H:%M:%S',
                                level=logging.DEBUG)

def send_mail(content):
    sender='xxxxxxxx'
    password = 'xxxxxxxx'
    receiver='xxxxxxxx'

    ret = True

    try:
        msg = MIMEText(content,'plain', 'utf-8')
        msg['From'] = formataddr([NODE_NAME, sender])
        msg['To'] = formataddr([NODE_NAME, receiver])
        msg['Subject'] = NODE_NAME + " ChainX 监控"

        server = smtplib.SMTP_SSL("smtp.exmail.qq.com", 465)
        server.login(sender, password)
        server.sendmail(sender, [receiver,], msg.as_string())
        server.quit()
    except Exception:
        ret = False

    if ret:
        logging.info("邮件发送成功")
    else:
        logging.error("邮件发送失败")

def check_node(node):
    wss = create_connection(node)
    wss.send('{"id":1, "jsonrpc":"2.0", "method":"chain_getHeader"}')
    data =  json.loads(wss.recv())
    height = int(data["result"]["number"], 16)
    wss.close()

    return height

def check_sync():
    localHeight = check_node(LOCAL_NODE)
    remoteHeight1 = check_node(REMOTE_NODE_1)

    if abs(localHeight - remoteHeight1) < 10:
        logging.info("ChainX " + NODE_TAG + " Node: " + LOCAL_NODE + " is full sync.")
    else:
        remoteHeight2 = check_node(REMOTE_NODE_2)
        if abs(localHeight - remoteHeight2) < 10:
            logging.info("ChainX " + NODE_TAG + " Node: " + LOCAL_NODE + " is full sync.")
        else:
            logging.error("ChainX " + NODE_TAG + " Node: " + LOCAL_NODE + " is not full sync.")
            send_mail("ChainX " + NODE_TAG + " Node: " + LOCAL_NODE + " is not full sync.")

def main():
    log_config()
    check_sync()

if __name__ == "__main__":
    main()