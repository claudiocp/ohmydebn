#!/bin/bash

if [ ! -d ~/.config/rofi ]; then
  ~/.local/share/ohmydebn/bin/ohmydebn-headline "cat" "Configuring rofi"
  cp -av ~/.local/share/ohmydebn/config/rofi ~/.config/
  echo
fi
