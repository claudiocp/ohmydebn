#!/bin/bash

UFW_STATE=~/.local/state/ohmymint-ufw
if [ ! -f $UFW_STATE ]; then
  ~/.local/share/ohmymint/bin/ohmymint-headline "cat" "Configuring firewall to deny inbound connections"
  sudo ufw enable
  sudo ufw default deny incoming
  sudo ufw default allow outgoing
  mkdir -p ~/.local/state
  touch $UFW_STATE
fi
