#!/bin/bash 

set -euxo pipefail

pushd advancements_json > /dev/null

    export SSHPASS="$(cat ssh_pass)"
    sshpass -e sftp -oBatchMode=no -oStrictHostKeyChecking=no -P 7767 -b - jctops.f2263ca4@eu-ger-06-9900k.node.dedicatedmc.io << EOF
get world_jan21/advancements/*.json
get whitelist.json
EOF
popd