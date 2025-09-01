#!/bin/bash

if [ ! -d ~/.config/chromium ]; then
  ~/.local/share/ohmydebn/bin/ohmydebn-headline "cat" "Configuring chromium"
  cp -av ~/.local/share/ohmydebn/config/chromium ~/.config/
  echo
fi
