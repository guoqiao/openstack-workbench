#!/bin/bash
set -ue


DEFAULT="vm0"
read -p "SERVER: [$DEFAULT] " INPUT
SERVER=${INPUT:-$DEFAULT}


openstack image list

DEFAULT="cirros-0.5.2-x86_64-disk"
read -p "IMAGE: [$DEFAULT] " INPUT
IMAGE=${INPUT:-$DEFAULT}

# TODO: other boot source

# 0 means no volume
DEFAULT="0"
read -p "VOLUME_SIZE: [$DEFAULT] " INPUT
VOLUME_SIZE=${INPUT:-$DEFAULT}

if [ "$VOLUME_SIZE" != "0" ]
then
    echo "Create New Volume"
    # TODO
else
    echo "No Volume Needed"
fi


openstack flavor list
DEFAULT="m1.small"
read -p "FLAVOR: [$DEFAULT] " INPUT
FLAVOR=${INPUT:-$DEFAULT}


openstack network list
DEFAULT="private"
read -p "NETWORK: [$DEFAULT] " INPUT
NETWORK=${INPUT:-$DEFAULT}

# TODO: select ports
# Ports provide extra communication channels to your instances. You can select ports instead of networks or a mix of both.


openstack security group list
DEFAULT="default"
read -p "SECURITY_GROUP: [$DEFAULT] " INPUT
SECURITY_GROUP=${INPUT:-$DEFAULT}
# TODO: create security group with common allowed ports


openstack keypair list
DEFAULT="${USER}-keypair"
read -p "KEYPAIR: [$DEFAULT] " INPUT
KEYPAIR=${INPUT:-$DEFAULT}


USERDATA=""
if ls ./*user*data*
then
    DEFAULT=""
    read -p "USERDATA: [$DEFAULT] " INPUT
    USERDATA=${INPUT:-$DEFAULT}
fi

# TODO: server group
