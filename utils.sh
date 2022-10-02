#!/bin/bash

# Colors
GREEN='\e[1;32m'
RED='\e[1;31m'
BLUE='\e[1;34m'
PURPLE='\e[1;35m'
YELLOW='\e[1;33m'
CYAN='\e[1;36m'
GRAY='\e[1;37m'
DARK_GRAY='\e[1;30m'
WHITE='\e[1;37m'
COLOR_OFF='\e[0m'

function output_running {
  printf "${PURPLE}--> ${COLOR_OFF}$1\n" 1>&2
}

function output_success {
  printf "${GREEN}++ OK: ${COLOR_OFF}$1\n" 1>&2
}

function output_skip {
  printf "${GREEN}-- SKIPPED: ${COLOR_OFF}$1\n" 1>&2
}

function output_header {
  printf "\n${WHITE}[[ ${COLOR_OFF}$1${WHITE} ]]${COLOR_OFF}\n\n" 1>&2
}

function output_debug {
  if [ "$VERBOSE" = 1 ] ; then
    printf "${DARK_GRAY}| DEBUG: ${COLOR_OFF}$1\n" 1>&2
  fi
}

function output_warning {
  printf "${YELLOW}! WARNING: ${COLOR_OFF}$1\n" 1>&2
}

function error {
  printf "\n${RED}!! ERROR: ${COLOR_OFF}$1\n\nExiting.\n" 1>&2
  exit 1
}

function wait_for_enter {
    printf "${CYAN}"
    read -p "Press [Enter] key to continue..."
    printf "${COLOR_OFF}"
}

function banner {
printf "\n\n"
printf "${GREEN}                       ____   _____   _                 _       _                   ${COLOR_OFF}\n"
printf "${GREEN}                      / __ \ / ____| | |               | |     | |                  ${COLOR_OFF}\n"
printf "${GREEN} _ __ ___   __ _  ___| |  | | (___   | |__   ___   ___ | |_ ___| |_ _ __ __ _ _ __  ${COLOR_OFF}\n"
printf "${GREEN}| \'_ \` _ \ / _\` |/ __| |  | |\___ \  | '_ \ / _ \ / _ \| __/ __| __| '__/ _\` | \'_ \ ${COLOR_OFF}\n"
printf "${GREEN}| | | | | | (_| | (__| |__| |____) | | |_) | (_) | (_) | |_\__ \ |_| | | (_| | |_) |${COLOR_OFF}\n"
printf "${GREEN}|_| |_| |_|\__,_|\___|\____/|_____/  |_.__/ \___/ \___/ \__|___/\__|_|  \__,_| .__/ ${COLOR_OFF}\n"
printf "${GREEN}                                                                             | |    ${COLOR_OFF}\n"
printf "${GREEN}                                                                             |_|    ${COLOR_OFF}\n\n"
printf "${DARK_GRAY}Thanks:                                                                         ${COLOR_OFF}\n"
printf "${BLUE}https://github.com/feffi/ansible-macos-bootstrap/                                    ${COLOR_OFF}\n\n\n"
}

# Check whether a command exists - returns 0 if it does, 1 if it does not
function exists {
  output_debug "Checking if the '$1' command is present."
  if command -v $1 >/dev/null 2>&1
  then
  output_debug "Command '$1' is present."
  return 0
  else
  output_debug "Command '$1' is not present."
  return 1
  fi
}

function fail_on_error {
  if ! $1
  then error "Command '$1' returned a non zero exit code."
  fi
}

function warn_on_error {
  if ! $1
  then output_warning "Command '$1' returned a non zero exit code."
  fi
}