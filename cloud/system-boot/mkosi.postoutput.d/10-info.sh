#!/usr/bin/bash

set -eo pipefail

file="${IMAGE_ID}_${IMAGE_VERSION}.partitions"
mv "${SRCDIR}/partitions" "${OUTPUTDIR}/${file}"
