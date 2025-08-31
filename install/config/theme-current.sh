#!/bin/bash

if [ ! -f $STATE_FILE ]; then
  display "cat" "Setting theme"
  mkdir -p ~/.config/$PROJECT_LOWER/current
  ~/.local/share/ohmydebn/bin/ohmydebn-theme-set Ohmydebn
fi
