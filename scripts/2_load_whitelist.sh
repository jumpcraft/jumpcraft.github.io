#!/bin/bash

set -euo pipefail

VALUES_STRING="$(cat data/whitelist.json| jq -r """[.[] | \"('\(.name)','\(.uuid)')\"] | join(\", \")""")"

echo $VALUES_STRING

mysql --defaults-file=my.cnf --defaults-group-suffix=jumpcraft -e """
REPLACE INTO user_ids (
    username,
    id
) VALUES ${VALUES_STRING};
"""