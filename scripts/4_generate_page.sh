#!/bin/bash

set -euxo pipefail


GROUP_TABLE="$(mysql --defaults-file=my.cnf --defaults-group-suffix=jumpcraft -H < get_group_table.sql)"
PLAYER_TABLE="$(mysql --defaults-file=my.cnf --defaults-group-suffix=jumpcraft -H < get_player_table.sql)"

echo "${GROUP_TABLE}" > tmp.html

cp template.html index.html

# Account for BSD sed being horrible
[[ -x "$(command -v gsed)" ]] && s=gsed || s=sed

$s -i -e '/GROUP_TABLE/r tmp.html' index.html

echo "${PLAYER_TABLE}" > tmp.html

$s -i -e '/PLAYER_TABLE/r tmp.html' index.html

rm tmp.html