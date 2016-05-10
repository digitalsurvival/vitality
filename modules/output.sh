# $Id$

# Colors
GOOD='\033[32;01m'
WARN='\033[33;01m'
BAD='\033[31;01m'
HILITE='\033[36;01m'
BRACKET='\033[34;01m'
NORMAL='\033[0m'

LOG_FILE="${LOG_DIR}/output.txt"

log() {
	local MSG="${1}"

	if [[ ! -e "${LOG_DIR}" ]]; then
		mkdir -p "${LOG_DIR}" || error "Cannot create log directory (${LOG_DIR})!"
	fi

	if [[ -n "${LOG_FILE}" ]]; then
		echo "$(date '+%b %d, %Y %T') - ${MSG}" 2>/dev/null >> "${LOG_FILE}" || error "Cannot write log file (${LOG_FILE})!"
	fi
}

debug() {
	local FUNC="${1}"
	local MSG="${2}"

	if [[ "${DEBUG}" = "1" ]]; then
		echo -e "${FUNC}(): ${MSG}" >&2
		log "${FUNC}(): ${MSG}"
	fi
}

notify() {
	local MSG="${1}"

	[[ "${QUITE}" = 0 ]] && echo -e " ${GOOD}*${NORMAL} ${MSG}\n"
	log "${MSG}"
}

error() {
	local MSG="${1}"
	echo -e " ${BAD}*${NORMAL} ${MSG}\n" >&2
	log "Error: ${MSG}"
}

die() {
	local MSG=$1

	error "${MSG}"
	exit 1
}

warn() {
	local MSG="${1}"

	[[ "${QUITE}" = 0 ]] && echo -e " ${WARN}*${NORMAL} ${MSG}\n" >&2
	log "Warning: ${MSG}"
}
