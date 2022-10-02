#!/bin/bash

set -u

abort() {
  printf "%s\n" "$@" >&2
  exit 1
}

echo "Starting bootstrap process..."

if [ -z "${BASH_VERSION:-}" ]
then
  abort "Bash is required to interpret this script."
fi

echo "- Creating ~/.bootstrap..."
mkdir -p ~/.bootstrap
echo "- Fetching scripts..."
curl -sSLo ~/.bootstrap/bootstrap.sh https://raw.githubusercontent.com/cbw/bootstrap/main/bootstrap.sh
curl -sSLo ~/.bootstrap/bootstrap.yaml https://raw.githubusercontent.com/cbw/bootstrap/main/bootstrap.yaml
curl -sSLo ~/.bootstrap/requirements.yaml https://raw.githubusercontent.com/cbw/bootstrap/main/requirements.yaml
curl -sSLo ~/.bootstrap/aws.env https://raw.githubusercontent.com/cbw/bootstrap/main/aws.env
chmod 755 ~/.bootstrap/bootstrap.sh

echo "- Executing bootstrap:"
(cd ~/.bootstrap; ./bootstrap.sh)