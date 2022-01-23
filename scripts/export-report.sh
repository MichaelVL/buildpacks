#! /bin/bash

# Simple implementation of https://github.com/buildpacks/rfcs/blob/main/text/0040-export-report.md

set -e

LOG=${1-"pack.log"}

DIGEST=$(grep -E '\[exporter\] \*\*\* Images .*' $LOG | grep -oE 'sha256:[a-z0-9]+')
TAGS=$(grep -A10 -E '\[exporter\] \*\*\* Images .*' $LOG | grep -E '\[exporter\]\s{6,}' | cut -c18-)

echo "[image]"
echo "tags = \"$TAGS\""
echo "digest = \"$DIGEST\""
