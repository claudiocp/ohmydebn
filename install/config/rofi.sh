#!/bin/bash

mkdir -p ~/.config
ROFI_CONFIG=~/.config/rofi

ROFI_STATE=~/.local/state/ohmymint-config/rofi-20250915
if [ ! -f $ROFI_STATE ]; then

  ~/.local/share/ohmymint/bin/ohmymint-headline "cat" "Configuring rofi"

  # If we have the old config, then rename it so we can add the new config
  if [ -d $ROFI_CONFIG ]; then
    mv $ROFI_CONFIG $ROFI_CONFIG-backup-$(date +%Y%m%d-%H%M%S)
  fi

  cp -av ~/.local/share/ohmymint/config/rofi ~/.config/
  echo
  touch $ROFI_STATE
fi
