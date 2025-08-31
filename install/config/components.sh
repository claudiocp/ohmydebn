#!/bin/bash

display "cat" "Configuring components"
for COMPONENT in alacritty bat btop cava chromium keepassxc rofi; do
  COMPONENT_CONFIG_DIR=~/.config/$COMPONENT
  if [ ! -d $COMPONENT_CONFIG_DIR ]; then
    echo "Configuring $COMPONENT:"
    cp -av ~/.local/share/ohmydebn/config/$COMPONENT ~/.config/
    echo
  fi
done
