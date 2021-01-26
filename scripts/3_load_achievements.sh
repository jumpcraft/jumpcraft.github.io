#!/bin/bash

set -euo pipefail

for f in data/advancements/*.json; do
    UUID="$(basename $f | cut -d'.' -f1)"
    VALUES_STRING="$(cat $f | jq -rcM """[to_entries | .[] | select(.value?.done?) | \"('${UUID}', '\(.key)', \(.value.done))\"] | join(\", \")""")"
    echo "Inserting achievements for ${UUID}"

    if [[ -z "$VALUES_STRING" ]]; then
        echo "No achievements for user $UUID"
        continue
    fi

    mysql --defaults-file=my.cnf --defaults-group-suffix=jumpcraft -e """
REPLACE INTO user_achievement (
    id,
    achievement,
    done
) VALUES ${VALUES_STRING};
"""
done