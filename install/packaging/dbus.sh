#!/bin/bash

if [ -f /usr/bin/pveversion ] && ! dpkg -s dbus-x11 >/dev/null 2>&1; then
  ~/.local/share/ohmymint/bin/ohmymint-headline "cat" "Installing dbus-x11"
  sudo apt -y install dbus-x11
  export $(dbus-launch)
fi
