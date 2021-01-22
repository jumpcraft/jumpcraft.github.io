#!/bin/bash

git pull
for s in scripts/*_*.sh; do
    ./$s
done