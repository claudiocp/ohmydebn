#!/bin/bash

if ! dpkg -s curl >/dev/null 2>&1 ||
  ! dpkg -s libglib2.0-bin >/dev/null 2>&1 ||
  ! dpkg -s python3-terminaltexteffects >/dev/null 2>&1 ||
  ! dpkg -s toilet >/dev/null 2>&1 ||
  ! dpkg -s toilet-fonts >/dev/null 2>&1; then

  ~/.local/share/ohmymint/bin/ohmymint-headline "cat" "Installing text effects for demoscene nostalgia"
  sudo apt update && sudo apt -y install curl \
    libglib2.0-bin \
    python3-terminaltexteffects \
    toilet \
    toilet-fonts
  # Most users are running a normal Linux Mint Cinnamon desktop and are running this script via gnome-terminal
  # In that case, let's change some terminal settings to make the output of this script look nicer
  if dpkg -s "gnome-terminal" >/dev/null 2>&1; then
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ foreground-color "'#D3D7CF'"
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ background-color "'#2E3436'"
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ use-theme-colors false
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ palette "['#2e3436', '#cc0000', '#4e9a06', '#c4a000', '#3465a4', '#75507b', '#06989a', '#d3d7cf', '#555753', '#ef2929', '#8ae234', '#fce94f', '#729fcf', '#ad7fa8', '#34e2e2', '#eeeeec']"
  fi
fi
