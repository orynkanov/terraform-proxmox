#!/bin/bash

SCRIPTDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

MODULE=$1

if [[ ! $# -eq 1 ]]; then
    echo "Usage - terraform-proxmox-taint.sh MODULE"
    exit 1
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

for TAINT in $(terraform show | grep module."$MODULE" | tr -d ':'); do
  terraform taint "$TAINT"
done
