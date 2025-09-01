#!/bin/bash

BAT_BIN=/usr/local/bin/bat
if [ ! -e $BAT_BIN ]; then
  echo "Creating symbolic link for bat"
  sudo ln -s /usr/bin/batcat /usr/local/bin/bat
fi

if [ ! -d ~/.config/bat ]; then
  echo "Copying bat config"
  cp -av ~/.local/share/ohmydebn/config/bat ~/.config/
fi

BAT_CACHE_METADATA=~/.cache/bat/metadata.yaml
if [ ! -f $BAT_CACHE_METADATA ]; then
  echo "Building cache for bat"
  bat cache --build
fi
