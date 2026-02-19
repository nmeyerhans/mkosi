#!/usr/bin/bash

# Partition UUIDs are stored in various places within the images, including the
# grub configuration and fstab, as well as in the partition/filesystem metadata
# itself.
# Note that not all images will use all UUIDs generated here.
outfile="${SRCDIR}/partitions"

echo PARTUUID_ROOT=$(uuid -v 5 "$SEED_UUID" PARTUUID_ROOT) > "${outfile}"
echo FSUUID_ROOT=$(uuid -v 5 "$SEED_UUID" FSUUID_ROOT) >> "${outfile}"
echo PARTUUID_ESP=$(uuid -v 5 "$SEED_UUID" PARTUUID_ESP) >> "${outfile}"

. "${outfile}"

test -n "$PARTUUID_ROOT"

echo "Generated build-specific UUIDs:"
cat "${outfile}"
