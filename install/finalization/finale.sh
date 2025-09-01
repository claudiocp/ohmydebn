#!/bin/bash

if [ -f ~/.local/state/ohmydebn ]; then
  echo
  echo "Update complete!"
else
  display "tte rain" "Installation complete!"
  echo
  welcome
  # Create a state file signifying that installation is complete
  mkdir -p ~/.local/state
  touch ~/.local/state/ohmydebn
fi
