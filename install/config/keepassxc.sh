#!/bin/bash

if [ ! -d ~/.config/keepassxc ]; then
  echo "Configuring keepassxc:"
  cp -av ~/.local/share/ohmydebn/config/keepassxc ~/.config/
  echo
fi
