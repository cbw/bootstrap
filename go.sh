#!/bin/bash

set -u

abort() {
  printf "%s\n" "$@" >&2
  exit 1
}

working_dir="/tmp/bootstrap-tmp"

echo "Starting bootstrap process..."

if [ -z "${BASH_VERSION:-}" ]
then
  abort "Bash is required to interpret this script."
fi

if [ -d "$working_dir" ]
then
    echo "- Cleaning up from previous run ($working_dir)..."
    rm -rf $working_dir
fi

echo "- Creating working directory ($working_dir)..."
mkdir -p $working_dir

echo "- Fetching bootstrap code from GitHub..."
curl -sSLo $working_dir/bootstrap.zip https://github.com/cbw/bootstrap/archive/refs/heads/main.zip

echo "- Unarchiving bootstrap code..."
unzip $working_dir/bootstrap.zip -d $working_dir >/dev/null 2>/dev/null

if ! [ $? -eq 0 ]; then
  echo "Failed to unzip bootstrap code :("
  exit 1
fi

echo "- Executing bootstrap process..."
chmod 755 $working_dir/bootstrap-main/bootstrap.sh
(cd $working_dir/bootstrap-main; ./bootstrap.sh)