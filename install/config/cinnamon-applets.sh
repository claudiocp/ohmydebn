#!/bin/bash

if [ ! -f $STATE_FILE ]; then
  if gsettings get org.cinnamon enabled-applets | grep -q grouped-window-list; then
    display "cat" "Changing grouped window list to window list"
    gsettings set org.cinnamon enabled-applets "$(gsettings get org.cinnamon enabled-applets | sed "s/panel1:left:[0-9]*:grouped-window-list@cinnamon.org:[0-9]*/panel1:left:1:window-list@cinnamon.org:12/")"
  fi

  if ! gsettings get org.cinnamon enabled-applets | grep -q workspace-switcher; then
    display "cat" "Enabling workspace switcher"
    gsettings set org.cinnamon enabled-applets "$(gsettings get org.cinnamon enabled-applets | sed 's/]$/, "panel1:right:0:workspace-switcher@cinnamon.org:10"]/')"
  fi
fi
