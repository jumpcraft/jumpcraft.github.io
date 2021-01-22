#!/bin/bash 

set -euxo pipefail

mkdir -p advancements_json

export SSHPASS="$(cat ssh_pass)"

pushd advancements_json > /dev/null
    sshpass -e sftp -oBatchMode=no -oStrictHostKeyChecking=no -P 7767 -b - jctops.f2263ca4@eu-ger-06-9900k.node.dedicatedmc.io << EOF
get world_jan21/advancements/*.json
get whitelist.json
EOF
popd