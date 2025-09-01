#!/bin/bash

if [ ! -d ~/.config/rofi ]; then
  echo "<< Configuring rofi >>"
  cp -av ~/.local/share/ohmydebn/config/rofi ~/.config/
  echo
fi
