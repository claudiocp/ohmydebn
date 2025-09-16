#!/bin/bash

if [ ! -d ~/.config/chromium ]; then
  ~/.local/share/ohmymint/bin/ohmymint-headline "cat" "Configuring chromium"
  mkdir -p ~/.config
  cp -av ~/.local/share/ohmymint/config/chromium ~/.config/
  echo
fi
