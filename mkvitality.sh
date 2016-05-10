#!/usr/bin/env bash

# Author: Matthew Marchese
# License: MIT
# Copyright: 2016 

VERSION_X=0 # Major
VERSION_Y=1 # Minor
VERSION_Z=0 # Patch

# Output variables
DEBUG=0
VERBOSE=0
QUITE=0

SCRIPT_NAME="${0##*/}"

import() {
	local module="${1}"

	if [[ -f "${module}.sh" ]]; then
		printf "Module ${module}.sh is missing. Re-installing should fix the problem.\n"
		exit 1
	else
		. modules/${module}.sh
		debug import "Imported module ${module}"
	fi
}

usage() {
	MSG="${1}"

	if [ -n "${MSG}" ]; then
		printf "${MSG}\n\n"
    fi
    cat <<EOF
usage:
  ${SCRIPT_NAME} [--option] <arguement>

options:
  -h|--help            Show this message and exit.
  -d|--debug           Output debugging messages.
  -q|--quiet           Only output fatal error messages.
  -v|--verbose         Be verbose (show command output).
  -V|--version         Print version and exit.

argument:
  <arch>       The architecture to built. Choose from
		amd64, arm, and x86
EOF
}

# These modules must be included
import output
import control

# Parse arguments
while [ ${#} -gt 0 ]; do
INPUT="${1}"
shift
	case "${INPUT}" in
		-h|--help)
			usage
			exit 0
		;;
		-d|--debug)
			DEBUG=1
		;;
		-q|--quiet)
			if [[ "${VERBOSE}" != "0" ]]; then
				usage "The --quiet and --verbose options are mutually exclusive. Choose only one." && exit 1
			fi
			QUITE=1
		;;
		-v|--verbose)
			if [[ "${QUITE}" != "0" ]]; then
				usage "The --quiet and --verbose options are mutually exclusive. Choose only one." && exit 1
			fi
			VERBOSE=1
		;;
		-V|--version)
			printf "${SCRIPT_NAME} v${VERSION_NUMBER}\nCopyright (C) 2016\nMatthew Marchese\nLicense: MIT\n\n"
			printf "To file a bug or to request a feature please visit:\nhttps://github.com/digitalsurvival/vitality\n"
			exit 0
		;;
		amd64|x86|arm)
			debug "${INPUT} has been selected"
			V_ARCH="${INPUT}"
		;;
		-*)
			usage "Invalid option specified: ${INPUT}" && exit 1
		;;
		*)
			usage "Invalid option specified: ${INPUT}" && exit 1
		;;
	esac
done

notify "${V_ARCH}"


