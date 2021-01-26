#!/bin/bash 

set -euxo pipefail

if [[ -d data ]]; then
    echo "Removing data dir"
    rm -r data
fi

mkdir -p data

export SSHPASS="$(cat ssh_pass)"

pushd data > /dev/null
    sshpass -e sftp -oBatchMode=no -oStrictHostKeyChecking=no -P 7767 -b - jctops.f2263ca4@eu-ger-06-9900k.node.dedicatedmc.io << EOF
get whitelist.json
cd world_jan21
get -r advancements
get -r stats
EOF

popd > /dev/null