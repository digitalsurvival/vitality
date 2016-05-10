# $Id$

# This function checks for existing specific system tools on the live medium (just to be safe)
# Add logic to correctly check for existing tools...
dep_check() {
tool_list=[$@]

  if [ ! -x "`which ${tool} 2>&1`" ]; then
    error "It appears ${tool} is missing. Please make sure it is installed before running Stage7 with the current install profile."
    exit 1
  else
  tool_location=`which ${tool}`
  debug pre_chroot_tool_check " Successfully located ${tool} utility at ${tool_location}"
  fi

}

get_arch() {
  ${linux32} uname -m | sed -e 's:i[3-6]86:x86:' -e 's:x86_64:amd64:' -e 's:parisc:hppa:'
}

}

unpack_tarball() {
  local file=$1
  local dest=$2
  local preserve=$3

  tar_flags="xv"

  if [ "$preserve" = "1" ] || [ "$preserve" = "yes" ]; then
    tar_flags="${tar_flags}p"
  fi

  extension=$(echo "$file" | sed -e 's:^.*\.\([^.]\+\)$:\1:')
  case $extension in
    gz)
      tar_flags="${tar_flags}z"
      ;;
    bz2)
      tar_flags="${tar_flags}j"
      ;;
    lz*|xz*)
      tar_flags="${tar_flags}l"
      ;;
  esac

  spawn "tar -C ${dest} -${tar_flags} -f ${file}"
  return $?
}
