# ChainX Backup

> ChainX backup tools.

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

- Ubuntu 16.04.1 LTS
- Written in bash

### Clone

- Clone this repo to your server using:

``` bash
cd /data/ExinPool && git clone https://github.com/ExinPool/ChainX
```

### Setup

Change some varibles like.

``` bash
CHAINX_DIR="/backup/chains"
BACKUP_TAG="chains"
BACKUP_DIR="/backup/data/chainx"
BACKUP_TIME=`date '+%Y%m%d%H%M%S'`
SLEEP_TIME=60
```

Add crontab like this.

``` bash
0 3 * * * nohup bash /data/ExinPool/ChainX/backup//chainx_backup.sh >> /home/${YOUR_USER}/chainx_backup.log &
```

The crontab will run every day at 3am then you can check the log in `/home/${YOUR_USER}/chainx_backup.log`.

The backup only keep 3 days. You can change this according to your server disk capacity.

## Features

- Backup ChainX node regularly.
- Archive backup according to your demand.

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