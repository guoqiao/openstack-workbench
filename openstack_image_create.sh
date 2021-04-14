#!/bin/bash
set -xue

IMG_URL=http://download.cirros-cloud.net/0.5.2/cirros-0.5.2-x86_64-disk.img
# IMG=http://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img
# IMG=http://cloud-images.ubuntu.com/bionic/current/bionic-server-cloudimg-amd64.img
FILE_NAME=$(basename -- "$IMG_URL")
IMG_NAME="${FILE_NAME%.*}"

curl $IMG | openstack image create --public --container-format=bare --disk-format=qcow2 $IMG_NAME
