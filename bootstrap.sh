#!/bin/bash

SCRIPT_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$SCRIPT_DIR" ]]; then SCRIPT_DIR="$PWD"; fi
. $SCRIPT_DIR/utils.sh

banner

# Install Homebrew if not already installed
if ! [ -x "$(command -v brew)" ]; then
  output_running 'Homebrew not installed - installing'
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Ansible if not already installed
if ! [ -x "$(command -v ansible)" ]; then
  output_running 'Ansible not installed - installing'
  brew install ansible
fi

output_running "Installing Ansible Galaxy requirements"
ansible-galaxy install -r requirements.yaml -p roles.galaxy/

output_running "Executing Ansible playbook"
ansible-playbook -i inventory bootstrap.yaml -K --connection=local
