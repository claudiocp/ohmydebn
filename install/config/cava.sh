#!/bin/bash

if [ ! -d ~/.config/cava ]; then
  ~/.local/share/ohmydebn/bin/ohmydebn-headline "cat" "Configuring cava"
  mkdir -p ~/.config
  cp -av ~/.local/share/ohmydebn/config/cava ~/.config/
  echo
fi
