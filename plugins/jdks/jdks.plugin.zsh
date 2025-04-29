function jdks() {
    if [[ $# -lt 2 ]]; then
      >&2 echo "Must supply a version and command"
    else
      local VERSION=$1
      local VERSION=$1
      local CMD=$2
      shift
      shift

      /usr/libexec/java_home -F -v "$VERSION" --exec "$CMD" "$@"
    fi
}

function _jdks {
  local BINDIR="$(/usr/libexec/java_home)/bin"

  _arguments \
    "1:version[Specify the version of the JDK to use]:_version_opts" \
    "2:binary[Specify the JDK binary to run]:_path_files -W '$BINDIR' -g '*(.)'" \
    "*::arg:->args"
}

_version_opts() {
  local -a options
  local default

  default="$(_default_version)"
  compadd "$default"

  options=("${(@f)$(_installed_versions | grep -v "$default" | uniq)}")
  compadd -a options
}

_default_version() {
  java -XshowSettings:all -version 2>&1 | sed -Ern 's/^ *java.version *= *([^ ]*) *$/\1/p'
}

_installed_versions() {
  /usr/libexec/java_home -V 2>&1 | sed -Ern 's/^  *([^ ]*[0-9]).*$/\1/p'
}

compdef _jdks jdks
