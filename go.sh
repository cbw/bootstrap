#!/bin/bash

set -u

abort() {
  printf "%s\n" "$@" >&2
  exit 1
}

if [ -z "${BASH_VERSION:-}" ]
then
  abort "Bash is required to interpret this script."
fi

mkdir -p ~/.bootstrap
curl -sSLo ~/.bootstrap/bootstrap.sh https://raw.githubusercontent.com/cbw/bootstrap/main/bootstrap.sh
curl -sSLo ~/.bootstrap/bootstrap.yaml https://raw.githubusercontent.com/cbw/bootstrap/main/bootstrap.yaml
curl -sSLo ~/.bootstrap/requirements.yaml https://raw.githubusercontent.com/cbw/bootstrap/main/requirements.yaml
chmod 755 ~/.bootstrap/bootstrap.sh

~/.bootstrap/bootstrap.sh