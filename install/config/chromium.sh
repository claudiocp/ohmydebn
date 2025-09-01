#!/bin/bash

if [ ! -d ~/.config/chromium ]; then
  echo "<< Configuring chromium >>"
  cp -av ~/.local/share/ohmydebn/config/chromium ~/.config/
  echo
fi
