#!/bin/bash
set -ue

PRIVATE_KEY=$HOME/.ssh/id_rsa

if [ ! -f $PRIVATE_KEY ]
then
    ssh-keygen -b 2048 -t rsa -N "" -f ${PRIVATE_KEY}
fi

openstack keypair create --public-key ${PRIVATE_KEY}.pub ${USER}-keypair
