#!/bin/bash

# Install Homebrew if not already installed
if ! [ -x "$(command -v brew)" ]; then
  echo 'Homebrew not installed - installing'
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Ansible if not already installed
if ! [ -x "$(command -v ansible)" ]; then
  echo 'Ansible not installed - installing'
  brew install ansible
fi

ansible-galaxy install -r requirements.yaml -p roles/

ansible-playbook bootstrap.yaml
