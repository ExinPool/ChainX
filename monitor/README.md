# ChainX Monitor

> ChainX node monitor tools.

[![Build Status](http://img.shields.io/travis/badges/badgerbadgerbadger.svg?style=flat-square)](https://travis-ci.org/badges/badgerbadgerbadger) [![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)

## Table of Contents

- [Installation](#installation)
- [Features](#features)
- [Contributing](#contributing)
- [Team](#team)
- [FAQ](#faq)
- [Support](#support)
- [License](#license)

## Installation

- Python 2.7+ required

### Clone

- Clone this repo to your server using:

``` bash
sudo mkdir -p /data/monitor/exinpool
cd /data/monitor/exinpool
sudo git clone https://github.com/ExinPool/ChainX
```
### Setup

Install related dependencies.

``` bash
apt-get -y install pip
pip install websocket_client
pip install pyyaml
```

Search `7000000012` in [Mixin Messenger](https://mixin.one/messenger) and add **[Webhook](https://mixin.one/codes/4d792128-1db8-4baf-8d90-d0d8189a4a7e)** as contact.

Invite Webhook and somebody who want to receive monitor message to a small group in Mixin Messenger. Open Webhook in the group, you can see the access token.

> Note: The access token is only available for the owner of the group.

Then copy `config.template.yml` to `config.yml` add update this yaml configuration.

``` bash
node_name: "ExinPool"
service_name: "ChainX"
log_file: "chainx_blocks.log"
webhook:
  webhook_url: "https://webhook.exinwork.com/api/send?access_token={}"
  access_token: ""
node:
  api_url: "http://api.mixinwallet.com/getinfo?node="
  node_tag: "VALIDATOR"
  local_node: "ws://127.0.0.1:8087"
  remote_node_1: "wss://ws.chainxtools.com"
  remote_node_2: "wss://chainx.maiziqianbao.net/ws"
mail:
  sender: ""
  password: ""
  receiver: ""
  subject: "ChainX Monitor"
  smtp_url: "smtp.exmail.qq.com"
  smtp_port: 465
```

Finally, add crontab like this.

``` bash
* * * * * nohup bash /data/ExinPool/ChainX/monitor/chainx_blocks_crontab.sh &
```

The crontab will run every minutes then you can check the log in `/home/${YOUR_USER}/chainx_blocks.log`.

When the node is not full sync with the remote node, you can receive message in the Mixin Messenger.

## Features

- Monitor multiple node like validator, sync and backup
- Send alarm message when node is not full sync
- Send alarm message via Webhook which based on Mixin API

## Contributing

To be continued.

## Team

@ExinPool

## FAQ

To be continued.

## Support

Reach out to us at one of the following places!

- Website at <a href="https://exinpool.com" target="_blank">`exinpool.com`</a>
- Twitter at <a href="http://twitter.com/ExinPool" target="_blank">`@ExinPool`</a>
- Email at `robin@exin.one`

## License

[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)

- **[MIT license](https://opensource.org/licenses/mit-license.php)**
- Copyright 2019 © <a href="https://exinpool.com" target="_blank">ExinPool</a>.