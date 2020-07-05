#!/bin/bash

#silent execution:
#export TF_VAR_pm_password='PASSWORD'
#export TF_VAR_pm_host_sshpassword='PASSWORD'

SCRIPTDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

#start check
if [[ ! -f $SCRIPTDIR/vars.cfg ]]; then
    echo "File $SCRIPTDIR/vars.cfg not found"
    exit 1
fi
#finish check

# shellcheck source=/dev/null
source "$SCRIPTDIR"/vars.cfg

if [[ -z $TF_VAR_pm_password ]]; then
    # shellcheck disable=SC2154
    read -r -s -p "Enter password for proxmox login $TF_VAR_pm_user: " PMPASS
    export TF_VAR_pm_password=$PMPASS
    echo
fi

if [[ -z $TF_VAR_pm_host_sshpassword ]]; then
    # shellcheck disable=SC2154
    read -r -s -p "Enter password for proxmox SSH host login $TF_VAR_pm_host_sshuser: " SSHPASS
    export TF_VAR_pm_host_sshpassword=$SSHPASS
    echo
fi

cd "$SCRIPTDIR" || exit 1

#start check
if ! terraform init; then
    echo "terraform init failed"
    exit 1
fi
if ! terraform validate; then
    echo "terraform validate failed"
    exit 1
fi
if ! terraform plan -out=plan; then
    echo "terraform plan failed"
    exit 1
fi
#finish check

if ! terraform apply plan; then
    echo "terraform apply failed"
    exit 1
else
    echo "terraform apply OK"
fi
