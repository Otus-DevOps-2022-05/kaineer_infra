#!/bin/bash

echo "=== Update dpkg cache -- $(date +'%H:%M:%S')"
apt-get update

echo "=== Wait until apt is done -- $(date +'%H:%M:%S')"
while ps -ef | grep apt | grep -v grep > /dev/null; do sleep 1; done
