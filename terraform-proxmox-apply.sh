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
fi
echo

if [[ -z $TF_VAR_pm_host_sshpassword ]]; then
    read -r -s -p "Enter password for proxmox SSH host login $TF_VAR_pm_host_sshuser: " PASS
    export TF_VAR_pm_host_sshpassword=$PASS
fi
echo

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
if ! terraform plan -parallelism=1 -out=plan; then
    echo "terraform plan failed"
    exit 1
fi
#finish check

if ! terraform apply -parallelism=1 plan; then
    echo "terraform apply failed"
    exit 1
else
    echo "terraform apply OK"
fi
