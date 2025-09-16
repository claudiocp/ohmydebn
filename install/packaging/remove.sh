#!/bin/bash

if [ ! -f ~/.local/state/ohmymint ]; then
  if [ "$NO_UNINSTALL" = false ]; then
    ~/.local/share/ohmymint/bin/ohmymint-headline "tte rain" "Removing any unnecessary packages"
    sudo apt -y purge brasero \
      firefox* \
      thunderbird \
      gnome-calculator \
      gnome-chess \
      gnome-games \
      goldendict-ng \
      hexchat \
      hoichess \
      pidgin \
      remmina \
      transmission* \
      x11vnc
    sudo apt -y autoremove
  fi
fi
