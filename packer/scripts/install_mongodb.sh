#!/bin/bash

### Install mongodb from yandex repo
#
echo "=== Install mongodb from yandex -- $(date +'%H:%M:%S')"
apt-get install -y mongodb

### Start mongodb.service and make it run on restart
#
echo "=== Start mongodb and enable it -- $(date +'%H:%M:%S')"
systemctl start mongodb
systemctl enable mongodb
