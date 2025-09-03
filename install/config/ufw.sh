#!/bin/bash

UFW_STATE=~/.local/state/ohmydebn-ufw
if [ ! -f $UFW_STATE ]; then
  sudo ufw enable
  sudo ufw default deny incoming
  sudo ufw default allow outgoing
  mkdir -p ~/.local/state
  touch $UFW_STATE
fi
