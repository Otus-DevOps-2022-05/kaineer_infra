#!/bin/sh

FOLDER_ID=$(yc config list | grep ^folder | cut -f2 -d" ")

yc compute instance create \
  --name reddit-app \
  --hostname baked-reddit-app \
  --memory=4 \
  --create-boot-disk image-folder-id=${FOLDER_ID},image-family=reddit-full,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --metadata-from-file user-data=../packer/files/metadata.yml
