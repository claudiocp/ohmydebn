#!/bin/bash

if [ ! -f ~/.local/state/ohmydebn ]; then
  display "cat" "Setting cursor theme"
  gsettings set org.cinnamon.desktop.interface cursor-theme "'Bibata-Modern-Classic'"
fi
