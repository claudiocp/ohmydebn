#!/bin/bash

if [ ! -d ~/.config/chromium ]; then
  ~/.local/share/ohmydebn/bin/ohmydebn-headline "cat" "Configuring chromium"
  mkdir -p ~/.config
  cp -av ~/.local/share/ohmydebn/config/chromium ~/.config/
  echo
fi
