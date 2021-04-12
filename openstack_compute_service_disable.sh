#!/bin/bash
set -ue

openstack compute service list

echo -n "which host: " && read HPV

echo -n "disable reason: " && read REASON

openstack compute service set --disable --disable-reason "${REASON}" ${HPV} nova-compute

openstack compute service list | grep ${HPV}

echo "To enable: openstack compute service set --enable ${HPV} nova-compute"
