#!/bin/bash

# Upload current iTerm preferences
op run --env-file="aws.env" -- aws s3 cp ~/Library/Preferences/com.googlecode.iterm2.plist s3://cbw-app-data/iterm/com.googlecode.iterm2.plist

# Upload current Karabiner Elements preferences
op run --env-file="aws.env" -- aws s3 cp ~/.config/karabiner/karabiner.json s3://cbw-app-data/karabiner/karabiner.json 

# Upload current .zshrc file
op run --env-file="aws.env" -- aws s3 cp ~/.zshrc s3://cbw-app-data/zsh/zshrc 

# Upload current ssh_config file
op run --env-file="aws.env" -- aws s3 cp  ~/.ssh/config s3://cbw-app-data/ssh/config 

# Upload current .gitconfig file
op run --env-file="aws.env" -- aws s3 cp  ~/.gitconfig s3://cbw-app-data/git/gitconfig 


# TODO: package and upload Alfred configs: s3://cbw-app-data/alfred/alfred.zip
