#!/usr/bin/env bash

export BRANDING_LONG="Vitality Linux"
export BRANDING_SHORT="vitality"

export VERSION_NUMBER="${VERSION_X}.${VERSION_Y}.${VERSION_Z}"
export TIMESTAMP=$(date +\%Y.\%m.\%d)

export VERSION_FULL="${BRANDING_LONG} v${VERSION_NUMBER} - Built on ${TIMESTAMP}"

export BASE_DIR="/tmp/${BRANDING_SHORT}"
export CHROOT_DIR="${BASE_DIR}/chroot"
export RELEASE_DIR="${BASE_DIR}/release"
export LOG_DIR="${BASE_DIR}/logs"
