#!/bin/bash

echo "=== Move unit file $(date + '%H:%M:%S')"
sudo cp /tmp/reddit-puma.service /etc/systemd/system/reddit-puma.service

# Sometimes it just does not work :(
# echo "=== Wait until apt is done -- $(date +'%H:%M:%S')"
# while ps -ef | grep apt | grep -v grep > /dev/null; do sleep 1; done

echo "=== Remove lock file $(date +'%H:%M:%S')"
sudo rm /var/lib/dpkg/lock*

echo "=== Install git $(date +'%H:%M:%S')"
sudo apt install -y git

echo "=== Clone reddit into /home/appuser $(date +'%H:%M:%S')"
mkdir -p /home/appuser
cd /home/appuser
git clone -b monolith https://github.com/express42/reddit.git

echo "=== Install ruby gems $(date +'%H:%M:%S')"
cd reddit && bundle

sudo systemctl start reddit-puma
sudo systemctl enable reddit-puma
