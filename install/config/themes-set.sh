#!/bin/bash

if [ ! -f ~/.local/state/ohmydebn ]; then
  display "cat" "Setting theme"
  mkdir -p ~/.config/ohmydebn/current
  ~/.local/share/ohmydebn/bin/ohmydebn-theme-set Ohmydebn
fi
