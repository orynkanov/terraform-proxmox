#!/bin/bash

#silent execution:
#export TF_VAR_pm_password='PASSWORD'
#export TF_VAR_pm_host_sshpassword='PASSWORD'

SCRIPTDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

export TF_VAR_pm_api_url='https://hyper01.yozhu.home:8006/api2/json'
export TF_VAR_pm_user='root@pam'
export TF_VAR_pm_host_sshuser='root'

if [[ -z $TF_VAR_pm_password ]]; then
    read -r -s -p "Enter password for proxmox login $TF_VAR_pm_user: " PASS
    export TF_VAR_pm_password=$PASS
    echo
fi

if [[ -z $TF_VAR_pm_host_sshpassword ]]; then
    read -r -s -p "Enter password for proxmox SSH host login $TF_VAR_pm_host_sshuser: " PASS
    export TF_VAR_pm_host_sshpassword=$PASS
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
if ! terraform destroy; then
    echo "terraform destroy failed"
    exit 1
else
    echo "terraform destroy OK"
fi
