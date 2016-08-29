#!/bin/sh

set -v

curl -L -o /tmp/cloud-config.yaml "http://${1}/cloud-config.yaml" || exit 1
coreos-install -d /dev/sda -c /tmp/cloud-config.yaml || exit 1

ROOT_DEV=$(blkid -t "LABEL=ROOT" -o device "/dev/sda"*)
mount ${ROOT_DEV} /mnt || exit 1
echo -ne "installation\ninstallation\n" | passwd core || exit 1
cp -vp /etc/shadow /mnt/etc/shadow || exit 1
umount /mnt || exit 1

reboot || exit 1

