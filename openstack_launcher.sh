#!/bin/bash
set -ue

CMD="openstack server create --wait"


openstack keypair list
echo "if no keypair, cancel this and create"
DEFAULT="${USER}-keypair"
read -p "KEYPAIR: [$DEFAULT] " INPUT
KEYPAIR=${INPUT:-$DEFAULT}
CMD+=" --key-name $KEYPAIR"


# only list current project, otherwise create will fail
openstack security group list --project $OS_PROJECT_NAME
DEFAULT="default"
read -p "SECURITY_GROUP (UUID preferred): [$DEFAULT] " INPUT
SECURITY_GROUP=${INPUT:-$DEFAULT}
[ -n "$SECURITY_GROUP" ] && CMD+=" --security-group $SECURITY_GROUP"


openstack image list
DEFAULT="cirros-0.5.2-x86_64-disk"
read -p "IMAGE: [$DEFAULT] " INPUT
IMAGE=${INPUT:-$DEFAULT}
CMD+=" --image $IMAGE"


# 0 means no volume
DEFAULT=""
read -p "if you want to boot from volume, specify the size in GB: [$DEFAULT] " INPUT
VOLUME_SIZE=${INPUT:-$DEFAULT}
[ -n "$VOLUME_SIZE" ] && CMD+=" --boot-from-volume $VOLUME_SIZE"


openstack flavor list
DEFAULT="m1.small"
read -p "FLAVOR: [$DEFAULT] " INPUT
FLAVOR=${INPUT:-$DEFAULT}
CMD+=" --flavor $FLAVOR"


openstack network list
DEFAULT="private"
read -p "NETWORK: [$DEFAULT] " INPUT
NETWORK=${INPUT:-$DEFAULT}
CMD+=" --network $NETWORK"


openstack hypervisor list
DEFAULT=""
read -p "HYPERVISOR: [$DEFAULT] " INPUT
HYPERVISOR=${INPUT:-$DEFAULT}
[ -n "$HYPERVISOR" ] && CMD+=" --availability-zone nova:$HYPERVISOR"


# optional
ls ./*userdata*
DEFAULT=""
read -p "USERDATA: [$DEFAULT] " INPUT
USERDATA=${INPUT:-$DEFAULT}
[ -n "$USERDATA" ] && CMD+=" --user-data $USERDATA"


DEFAULT="vm0"
read -p "SERVER: [$DEFAULT] " INPUT
SERVER=${INPUT:-$DEFAULT}
CMD+=" $SERVER"

cat << EOF

Final cmd:

    $CMD

EOF

read -p "do you want to execute above cmd? [Y/n] " YES
YES=${YES:-y}
[ "${YES,,}" == "y" ] && eval $CMD
