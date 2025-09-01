#!/bin/bash

BAT_BIN=/usr/local/bin/bat
if [ ! -e $BAT_BIN ]; then
  display "cat" "Creating symbolic link for bat"
  sudo ln -s /usr/bin/batcat /usr/local/bin/bat
fi

BAT_CACHE_METADATA=~/.cache/bat/metadata.yaml
if [ ! -f $BAT_CACHE_METADATA ]; then
  display "cat" "Building cache for bat"
  bat cache --build
fi
