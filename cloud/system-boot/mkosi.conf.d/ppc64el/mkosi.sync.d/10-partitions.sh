#!/usr/bin/bash

echo PARTUUID_ROOT=$(uuid) > "${SRCDIR}/partitions"
echo FSUUID_ROOT=$(uuid) >> "${SRCDIR}/partitions"

. "${SRCDIR}/partitions"

test -n "$PARTUUID_ROOT"

echo "Generated build-specific UUIDs:"
cat "${SRCDIR}/partitions"

echo "### Updating repart configuration"
mkdir "${SRCDIR}/system-boot/mkosi.conf.d/ppc64el/mkosi.repart/10-root.conf.d"
echo "[Partition]" > "${SRCDIR}/system-boot/mkosi.conf.d/ppc64el/mkosi.repart/10-root.conf.d/uuid.conf"
echo "UUID=$PARTUUID_ROOT" >> "${SRCDIR}/system-boot/mkosi.conf.d/ppc64el/mkosi.repart/10-root.conf.d/uuid.conf"

echo "Generated repart config:"
for f in $(find "${SRCDIR}/system-boot/mkosi.conf.d/ppc64el/mkosi.repart/" -type f -name '*.conf'); do
    echo "# $f"
    cat "$f"
done
