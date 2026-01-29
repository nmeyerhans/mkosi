#!/usr/bin/bash

# Partition UUIDs are stored in various places within the images, including the
# grub configuration and fstab, as well as in the partition/filesystem metadata
# itself.
outfile="${SRCDIR}/partitions"

echo PARTUUID_ROOT=$(uuid) > "${outfile}"
echo FSUUID_ROOT=$(uuid) >> "${outfile}"
echo PARTUUID_ESP=$(uuid) >> "${outfile}"

. "${outfile}"

test -n "$PARTUUID_ROOT"

echo "Generated build-specific UUIDs:"
cat "${outfile}"
