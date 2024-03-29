#!/bin/bash

SCRIPT_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$SCRIPT_DIR" ]]; then SCRIPT_DIR="$PWD"; fi
. $SCRIPT_DIR/utils.sh

banner

# Install Homebrew if not already installed
if ! [ -x "$(command -v brew)" ]; then
  output_running 'Homebrew not installed - installing'
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  PATH="/opt/homebrew/bin:$PATH"
fi

# Install Ansible if not already installed
if ! [ -x "$(command -v ansible)" ]; then
  output_running 'Ansible not installed - installing'
  brew install ansible
fi

# Check to ensure we're logged into iCloud
until /usr/libexec/PlistBuddy -c "print :Accounts:0:AccountID" ~/Library/Preferences/MobileMeAccounts.plist > /dev/null 2> /dev/null
do
  output_warning 'Please log into iCloud before continuing'
  wait_for_enter
done

# Install 1Password if not already installed
if ! [ -d "/Applications/1Password.app" ]; then
  output_running 'Installing 1Password'
  brew install --cask 1password
fi

# Install 1Password CLI if not already installed
if [ -z $(which op) ] || ! [ -x $(which op) ]; then
  output_running 'Installing 1Password CLI'
  brew install --cask 1password-cli
fi

# Check to ensure we're logged into 1Password
until op account get > /dev/null 2> /dev/null
do
  output_warning 'Please log into 1Password and enable the SSH agent before continuing'
  wait_for_enter
done

output_running "Installing Ansible Galaxy requirements"
ansible-galaxy install -r requirements.yaml -p roles.galaxy/

output_running "Executing Ansible playbook"
op run --env-file="ansible.env" -- ansible-playbook -i inventory bootstrap.yaml --connection=local --ask-become-pass
