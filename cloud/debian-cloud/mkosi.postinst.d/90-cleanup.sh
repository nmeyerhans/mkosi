#!/usr/bin/bash

# mkosi leaves some things in the wrong place.
rmdir "${BUILDROOT}/efi" 2> /dev/null
rm -f "${BUILDROOT}"/vmlinu[zx]* "${BUILDROOT}"/initrd.* "${BUILDROOT}"/init

exit 0
