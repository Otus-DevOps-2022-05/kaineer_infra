#!/bin/bash

# --> Fetch application
#
sudo apt install -y git

APP_DIR="/home/appuser/reddit"
if [ ! -d $APP_DIR ]
then
	mkdir -p $APP_DIR
	git clone -b monolith https://github.com/express24/reddit.git $APP_DIR
	chown appuser:appuser -R $APP_DIR
fi

# --> Fetch dependencies
#
cd $APP_DIR
bundle

# --> Setup puma.service
#
sudo mv /tmp/puma.service /etc/systemd/system/puma.service
sudo systemctl start puma
sudo systemctl enable puma
