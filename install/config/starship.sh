#!/bin/bash

STARSHIP_CONFIG=~/config/starship.toml
if [ ! -f $STARSHIP_CONFIG ]; then
  display "cat" "Configuring starship prompt"
  cp ~/.local/share/$PROJECT_LOWER/config/starship.toml ~/.config/
fi
