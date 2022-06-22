#!/bin/bash

### That rake we already walked
###
### wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
### echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodborg/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
###
### sudo apt update

### Install mongodb from yandex repo
#
sudo apt install -y mongodb

### Start mongodb.service and make it run on restart
#
sudo systemctl start mongodb
sudo systemctl enable mongodb
