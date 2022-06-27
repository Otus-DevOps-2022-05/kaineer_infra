#!/bin/bash

### Install git
#
sudo apt install -y git

### Clone reddit into $HOME
#
cd
git clone -b monolith https://github.com/express42/reddit.git

### Install dependencies
#
cd reddit && bundle

### Start webserver
#
puma -d
