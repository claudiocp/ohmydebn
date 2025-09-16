#!/bin/bash

if [ ! -d ~/.config/keepassxc ]; then
  ~/.local/share/ohmymint/bin/ohmymint-headline "cat" "Configuring keepassxc"
  mkdir -p ~/.config
  cp -av ~/.local/share/ohmymint/config/keepassxc ~/.config/
  echo
fi
