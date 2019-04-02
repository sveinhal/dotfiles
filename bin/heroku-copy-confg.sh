#!/usr/bin/env bash
# Original Source: http://blog.nonuby.com/blog/2012/07/05/copying-env-vars-from-one-heroku-app-to-another/

## Usage: heroku_env_copy [options] SOURCE TARGET
##
## NOTE: This script will only output the command, you should run it yourself.
##
## Options:
##   -h, --help    Display this message.
##

usage() {
  [ "$*" ] && echo "$0: $*"
  sed -n '/^##/,/^$/s/^## \{0,1\}//p' "$0"
  exit 2
} 2>/dev/null

main() {
  while [ $# -gt 0 ]; do
    case $1 in
    (-h|--help) usage 2>&1;;
    (--) break;;
    (-*) usage "$1: unknown option";;
    (*) break;;
    esac
    shift
  done

  SOURCE="${1}"
  TARGET="${2}"
  vars=""

  echo "Please choose the ENV variables you wish to copy from $SOURCE to $TARGET:"
  echo ""

  while read key value; do
    key=${key%%:}
    read -p "Include: $key=$value ? [Y/n] (default yes) " -u 1 response
    if printf "%s\n" "$response" | grep -Eq "$(locale noexpr)"
    then
      tput cuu 1 && tput el
      echo -e "$(tput setaf 9)Copy: $key=$value ? No$(tput sgr0)"
    else
      tput cuu 1 && tput el
      echo -e "$(tput setaf 2)Copy: $key=$value ? Yes$(tput sgr0)"
      vars=$vars" $key=\"$value\""
    fi
  done < <(heroku config --app "$SOURCE" | sed -e '1d')

  echo ""
  echo "--------------------------------------------------------------------"
  echo "This script will not do your dirty work for you. Below is the script"
  echo "you will need to run to update your heroku app instance. Good luck! "
  echo "--------------------------------------------------------------------"
  echo ""
  echo "heroku config:set$vars --app $TARGET"
  echo ""
}

set -e          # exit on command errors

main $@
