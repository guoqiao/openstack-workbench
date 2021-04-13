#!/bin/bash
set -xue

NAME=${1:-common}

openstack security group create $NAME --description "allow common ports"
openstack security group rule create --protocol icmp --remote-ip 0.0.0.0/0 $NAME
openstack security group rule create --protocol tcp  --dst-port 22  --remote-ip 0.0.0.0/0 $NAME
openstack security group rule create --protocol tcp  --dst-port 80  --remote-ip 0.0.0.0/0 $NAME
openstack security group rule create --protocol tcp  --dst-port 443 --remote-ip 0.0.0.0/0 $NAME
openstack security group show $NAME
