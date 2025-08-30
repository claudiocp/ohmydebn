#!/bin/bash

if [ ! -f $STATE_FILE ]; then
  display "cat" "Setting cursor theme"
  gsettings set org.cinnamon.desktop.interface cursor-theme "'Bibata-Modern-Classic'"
fi
