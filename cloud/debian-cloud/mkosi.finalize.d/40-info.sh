#!/bin/bash
set -euE
shopt -s extglob nullglob

ROOTCMD=mkosi-chroot

${ROOTCMD} dpkg -s > "${CHROOT_OUTPUTDIR}/${CLOUD_BUILD_NAME}.dpkg-status"

echo -n ${PARTUUID_ROOT} > "${CHROOT_OUTPUTDIR}/${CLOUD_BUILD_NAME}.data.root.partuuid"
echo -n ${PARTUUID_ESP} > "${CHROOT_OUTPUTDIR}/${CLOUD_BUILD_NAME}.data.efi.partuuid"
echo -n ${FSUUID_ROOT} > "${CHROOT_OUTPUTDIR}/${CLOUD_BUILD_NAME}.data.root.fsuuid"

exec > ${CHROOT_OUTPUTDIR}/${CLOUD_BUILD_NAME}.info

function show() {
  if [ ${#@} -ge 1 ]; then
    tail -vn +1 "$@" | sed -e "s:${BUILDROOT}::"
  fi
}

echo "--- CLOUD RELEASE ---"
cat ${BUILDROOT}/etc/cloud-release
echo "--- END CLOUD RELEASE --- "
echo "--- APT SOURCES.LIST ---"
if [ -n "${BUILDROOT}" ] ; then
	if [ -r ${BUILDROOT}/etc/apt/sources.list ] ; then
		show ${BUILDROOT}/etc/apt/sources.list
	fi
	if [ -d "${BUILDROOT}/etc/apt/sources.list.d" ] ; then
		for i in $(find ${BUILDROOT}/etc/apt/sources.list.d -type f) ; do
			show ${i}
		done
	fi
fi
echo "--- END APT SOURCES.LIST ---"
echo "--- APT PREFERENCES ---"
if [ -n "${BUILDROOT}" ] ; then
	if [ -r "${BUILDROOT}/etc/apt/preferences" ] ; then
		show ${BUILDROOT}/etc/apt/preferences
	fi
	if [ -d "${BUILDROOT}/etc/apt/preferences.d" ] ; then
		for i in $(find ${BUILDROOT}/etc/apt/preferences.d -type f) ; do
			show ${i}
		done
	fi
fi
echo "--- END APT PREFERENCES ---"
echo "--- FILES CHANGED ---"
debsums -r ${BUILDROOT} -a -c | sed -e "s:^${BUILDROOT}::" || [ $? != 2 ]
echo "--- END FILES CHANGED ---"
echo "--- PACKAGES ---"
${ROOTCMD} dpkg -l
echo "--- END PACKAGES ---"
