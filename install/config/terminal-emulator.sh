#!/bin/bash

if [ ! -f ~/.local/state/ohmydebn ]; then
  display "cat" "Setting alacritty as default terminal emulator"
  gsettings set org.cinnamon.desktop.default-applications.terminal exec "'alacritty'"
fi
