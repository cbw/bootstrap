#!/bin/bash

# Upload current iTerm preferences
op run --env-file="aws.env" -- aws s3 cp ~/Library/Preferences/com.googlecode.iterm2.plist s3://cbw-app-data/iterm/com.googlecode.iterm2.plist2 