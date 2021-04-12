#!/bin/bash
set -ue

openstack compute service list

echo -n "which host: " && read HPV

openstack compute service set --enable ${HPV} nova-compute

openstack compute service list | grep ${HPV}
