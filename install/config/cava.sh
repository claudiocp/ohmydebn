#!/bin/bash

if [ ! -d ~/.config/cava ]; then
  ~/.local/share/ohmymint/bin/ohmymint-headline "cat" "Configuring cava"
  mkdir -p ~/.config
  cp -av ~/.local/share/ohmymint/config/cava ~/.config/
  echo
fi
