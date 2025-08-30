#!/bin/bash

if [ ! -f $STATE_FILE ]; then
  display "cat" "Setting alacritty as default terminal emulator"
  gsettings set org.cinnamon.desktop.default-applications.terminal exec "'alacritty'"
fi
