#!/bin/bash

if [ ! -f ~/.local/state/ohmymint ]; then
  ~/.local/share/ohmymint/bin/ohmymint-headline "cat" "Setting cursor theme"
  gsettings set org.cinnamon.desktop.interface cursor-theme "'Bibata-Modern-Classic'"
fi
