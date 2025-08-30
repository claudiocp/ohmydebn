#!/bin/bash

# Define variables
PROJECT="OhMyDebn"
PROJECT_LOWER=$(echo "$PROJECT" | tr '[:upper:]' '[:lower:]')
STATE_DIR=~/.local/state
mkdir -p $STATE_DIR
STATE_FILE=~/.local/state/$PROJECT_LOWER
export PATH="$HOME/.local/share/$PROJECT_LOWER/bin:$PATH"
OHMYDEBN_INSTALL=~/.local/share/$PROJECT_LOWER/install
