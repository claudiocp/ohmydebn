#!/bin/bash

if [ ! -d ~/.config/keepassxc ]; then
  ~/.local/share/ohmydebn/bin/ohmydebn-headline "cat" "Configuring keepassxc"
  mkdir -p ~/.config
  cp -av ~/.local/share/ohmydebn/config/keepassxc ~/.config/
  echo
fi
