#!/bin/bash

set -euxo pipefail

git add .
git commit -m "Autoupdate -> $(date)"
git push
