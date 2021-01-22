#!/bin/bash

echo "Running at $(date)"
git pull
for s in scripts/*_*.sh; do
    ./$s
done