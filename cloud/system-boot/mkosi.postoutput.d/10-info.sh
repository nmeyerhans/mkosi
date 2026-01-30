#!/usr/bin/bash

set -eo pipefail

file="${IMAGE_ID}.partitions"
mv "${SRCDIR}/partitions" "${OUTPUTDIR}/${file}"
