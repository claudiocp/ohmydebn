#!/bin/bash

if [ ! -f ~/.local/state/ohmymint ]; then
  toilet -f mono12 "OhMyMint" | tte rain
  echo

  ~/.local/share/ohmymint/bin/ohmymint-headline "tte rain" "Configuring base OS"

  if ! dpkg -s "cinnamon-desktop-environment" >/dev/null 2>&1; then
    ~/.local/share/ohmymint/bin/ohmymint-headline "cat" "Installing Cinnamon desktop"
    sudo apt -y install cinnamon-desktop-environment
  fi

  # Linux Mint themes should already be available
  ~/.local/share/ohmymint/bin/ohmymint-headline "cat" "Linux Mint detected - themes should already be available"
fi
