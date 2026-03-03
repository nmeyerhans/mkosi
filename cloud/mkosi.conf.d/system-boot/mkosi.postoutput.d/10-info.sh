#!/usr/bin/bash
# SPDX-License-Identifier: GPL-2.0-or-later

set -eo pipefail

file="${IMAGE_ID}.partitions"
mv "${SRCDIR}/partitions" "${OUTPUTDIR}/${file}"
