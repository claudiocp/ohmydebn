#!/bin/bash

if [ ! -f $STATE_FILE ]; then
  if [ "$NO_UNINSTALL" = false ]; then
    display "tte rain" "Removing any unnecessary packages"
    sudo apt -y purge brasero firefox* thunderbird gnome-chess gnome-games goldendict-ng hexchat hoichess pidgin remmina \
      transmission* x11vnc
    sudo apt -y autoremove
  fi
fi
