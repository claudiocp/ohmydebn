#!/bin/bash

if [ -f ~/.local/state/ohmymint ]; then
  ~/.local/share/ohmymint/bin/ohmymint-headline "tte rain" "OhMyMint update complete!"
else
  echo
  ~/.local/share/ohmymint/bin/ohmymint-headline "tte rain" "Installation complete!"
  echo
  toilet -f mono12 "Welcome" | tte rain
  toilet -f mono12 "   to" | tte rain
  toilet -f mono12 "OhMyMint" | tte rain
  # Create a state file signifying that installation is complete
  mkdir -p ~/.local/state
  touch ~/.local/state/ohmymint
fi
