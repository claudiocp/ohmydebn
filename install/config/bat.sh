#!/bin/bash

BAT_BIN=/usr/local/bin/bat
if [ ! -e $BAT_BIN ]; then
  ~/.local/share/ohmymint/bin/ohmymint-headline "cat" "Creating symbolic link for bat"
  sudo ln -s /usr/bin/batcat /usr/local/bin/bat
fi

if [ ! -d ~/.config/bat ]; then
  ~/.local/share/ohmymint/bin/ohmymint-headline "cat" "Configuring bat"
  mkdir -p ~/.config
  cp -av ~/.local/share/ohmymint/config/bat ~/.config/
fi

BAT_CACHE_METADATA=~/.cache/bat/metadata.yaml
if [ ! -f $BAT_CACHE_METADATA ]; then
  ~/.local/share/ohmymint/bin/ohmymint-headline "cat" "Building cache for bat"
  bat cache --build
fi
