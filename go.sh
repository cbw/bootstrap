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
curl -o ~/.bootstrap/bootstrap.sh https://raw.githubusercontent.com/cbw/bootstrap/main/bootstrap.sh
curl -o ~/.bootstrap/bootstrap.yaml https://raw.githubusercontent.com/cbw/bootstrap/main/bootstrap.yaml
curl -o ~/.bootstrap/requirements.yaml https://raw.githubusercontent.com/cbw/bootstrap/main/requirements.yaml
chmod 755 ~/.bootstrap/bootstrap.sh
