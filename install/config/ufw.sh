#!/bin/bash

UFW_STATE=~/.local/state/ohmydebn-ufw
if [ ! -f $UFW_STATE ]; then
  ~/.local/share/ohmydebn/bin/ohmydebn-headline "tte rain" "Configuring firewall to deny inbound connections"
  sudo ufw enable
  sudo ufw default deny incoming
  sudo ufw default allow outgoing
  mkdir -p ~/.local/state
  touch $UFW_STATE
fi
