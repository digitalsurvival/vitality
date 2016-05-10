#!/bin/bash

# Script updates stage files in various folders below stages with
# version values. Can update snapshots independantly.

source ../version

# Output a file containing tarball files
tar --list --file ${BASE_DIR}/chroot/*tar.xz >> ${RELEASE_DIR}/${BRANDING_SHORT}-v${VERSION_NUMBER}-filelist.txt

# Output a file with the tarball filecount
tar --list --file ${BASE_DIR}/chroot/*tar.xz | wc --lines >> ${RELEASE_DIR}/${BRANDING_SHORT}-v${VERSION_NUMBER}-filecount.txt

# Create md5dum, sha1sum, and sha512sum checksums
md5sum ${BASE_DIR}/chroot/*tar.xz >> ${RELEASE_DIR}/${BRANDING_SHORT}-v${VERSION_NUMBER}-checksums.txt
sha1sum ${BASE_DIR}/chroot/*tar.xz >> ${RELEASE_DIR}/${BRANDING_SHORT}-v${VERSION_NUMBER}-checksums.txt
sha512sum ${BASE_DIR}/chroot/*tar.xz >> ${RELEASE_DIR}/${BRANDING_SHORT}-v${VERSION_NUMBER}-checksums.txt
