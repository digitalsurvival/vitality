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

# mkvitality [--options] <arguement>
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
	msg=$1

	if [ -n "${msg}" ]; then
		printf "${msg}\n"
    else
    cat <<EOF
Usage:
  mkvitality  [--option] <arguement>

Options:
  -h|--help            Show this message and exit.
  -d|--debug           Output debugging messages.
  -q|--quiet           Only output fatal error messages.
  -v|--verbose         Be verbose (show command output).
  -V|--version         Print version and exit.

Arguments:
  <arch>       The architecture to built. Choose from
		amd64, arm, and x86
EOF
	fi
}

# These modules must be included
import output
import version

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
		-s|--sanity-check)
			sanitycheck=1
		;;
		-v|--verbose)
			if [[ "${QUITE}" != "0" ]]; then
				usage "The --quiet and --verbose options are mutually exclusive. Choose only one." && exit 1
			fi
			VERBOSE=1
		;;
		-V|--version)
			printf "Vitality version ${VERSION}\nCopyright (C) 2016 Matthew Marchese\nLicense: MIT\n\n"
			printf "To file a bug or to request a feature please visit:\nhttps://github.com/digitalsurvival/vitality\n\n"
			printf "This is free software; you are free to change and redistribute it.\nThere is NO WARRANTY, to the extent permitted by law.\n"
			exit 0
		;;
		-*)
			usage "Invalid option specified: ${INPUT}" && exit 1
		;;
		*)
			V_ARCH="${INPUT}"
		;;
	esac
done

echo "${V_ARCH}"
