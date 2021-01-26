#!/bin/bash

set -euo pipefail

# Cheap hack to ignore whitelist.json
for f in data/stats/*.json; do
    UUID="$(basename $f | cut -d'.' -f1)"
    JSON_LINES="$(cat $f | jq -rcM """.stats | to_entries | .[]""")"
    echo "Inserting stats for ${UUID}"

    if [[ -z "$JSON_LINES" ]]; then
        echo "No stats for user $UUID"
        continue
    fi
    echo "" > tmp_user_values

    echo "$JSON_LINES" | while read line; do
        CATEGORY="$(echo "$line" | jq -rcM '.key')"

        echo "  Category: $CATEGORY"
        VALUES_STRING="$(echo "$line" | jq -rcM """ .value | [to_entries | .[] | \"('${UUID}', '${CATEGORY}', '\(.key)', \(.value))\"] | join(\", \") """)"

        if [[ -z "$VALUES_STRING" ]]; then
            continue
        fi

        echo "$VALUES_STRING," >> tmp_user_values


    done

    VALUE_STRINGS="$(cat tmp_user_values)"

    if [[ -z "$VALUE_STRINGS" ]]; then
        echo " No stats to insert"
        continue
    fi

    mysql --defaults-file=my.cnf --defaults-group-suffix=jumpcraft -e """
REPLACE INTO user_stat (
    id,
    category,
    stat,
    value
) VALUES ${VALUE_STRINGS::-1};
"""

done

if [[ -f tmp_user_values ]]; then
    rm tmp_user_values
fi