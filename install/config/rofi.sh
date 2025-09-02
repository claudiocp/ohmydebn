#!/bin/bash

ROFI_CONFIG=~/.config/rofi

# If we have the old config, then rename it so we can add the new config
if [ -f $ROFI_CONFIG/catppuccin-default.rasi ]; then
  mv $ROFI_CONFIG $ROFI_CONFIG-$(date +%Y%m%d-%H%M%S)
fi

if [ ! -d $ROFI_CONFIG ]; then
  ~/.local/share/ohmydebn/bin/ohmydebn-headline "cat" "Configuring rofi"
  cp -av ~/.local/share/ohmydebn/config/rofi ~/.config/
  echo
fi
