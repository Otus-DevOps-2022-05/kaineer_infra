#!/bin/bash

sudo apt update

sudo apt install -y \
  ruby-full \
  ruby-bundler \
  build-essential # Need this to compile native gem extensions
