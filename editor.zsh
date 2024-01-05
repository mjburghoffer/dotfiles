#!/bin/zsh

# shellcheck disable=SC2076
# shellcheck disable=SC2154

function launch-editor() {
  local editor=$1
  local linenum
  local filename
  shift

  while [[ $# -gt 0 ]]; do
    local arg=$1

    if [[ $arg = '--line' ]]; then
      linenum=$2
      shift
      shift
    elif [[ $arg = '--file' ]]; then
      filename=$2
      shift
      shift
    elif [[ $arg =~ '^--line[= ]([0-9]+)$' ]]; then
      linenum=${match[1]}
      shift
    elif [[ $arg =~ '^\+([0-9]+)$' ]]; then
      linenum=${match[1]}
      shift
    elif [[ $arg =~ '^--file[= ](.+)$' ]]; then
      filename=${match[1]}
      shift
    elif [[ $arg =~ '^(.+):([0-9]+)$' ]]; then
      filename=${match[1]}
      linenum=${match[2]}
      shift
    elif [[ -z $filename ]]; then
      filename=$1
      shift
    elif [[ -z $linenum ]]; then
      linenum=$1
      shift
    else
      echo "Invalid editor arguments"
      exit 1
    fi
  done

  if [[ -z $filename ]]; then
    echo "No filename specified"
    exit 1
  fi

  local cmdtorun=("$editor")

  if [[ -v linenum ]]; then
    case $editor in
    webstorm|idea)
      cmdtorun+=("--line" "$linenum")
      ;;
    *)
      cmdtorun+=("+$linenum")
      ;;
    esac
  fi

  cmdtorun+=("$filename")

  "${cmdtorun[@]}"
}

launch-editor "$@"
