#!/bin/bash

echo "=== Install ruby packages -- $(date +'%H:%M:%S')"
apt install -y \
  ruby-full \
  ruby-bundler \
  build-essential
