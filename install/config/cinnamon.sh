#!/bin/bash

if [ ! -f ~/.local/state/ohmydebn ]; then
  if gsettings get org.cinnamon enabled-applets | grep -q grouped-window-list; then
    echo "Changing grouped window list to window list"
    gsettings set org.cinnamon enabled-applets "$(gsettings get org.cinnamon enabled-applets | sed "s/panel1:left:[0-9]*:grouped-window-list@cinnamon.org:[0-9]*/panel1:left:1:window-list@cinnamon.org:12/")"
  fi

  if ! gsettings get org.cinnamon enabled-applets | grep -q workspace-switcher; then
    echo "Enabling workspace switcher"
    gsettings set org.cinnamon enabled-applets "$(gsettings get org.cinnamon enabled-applets | sed 's/]$/, "panel1:right:0:workspace-switcher@cinnamon.org:10"]/')"
  fi

  echo "Configuring cinnamon spices"
  for SPICE in "workspace-switcher@cinnamon.org" "notifications@cinnamon.org" "calendar@cinnamon.org"; do
    SPICE_DIR=~/.config/cinnamon/spices/$SPICE
    mkdir -p $SPICE_DIR
    echo "Configuring $SPICE"
    cp -av ~/.local/share/ohmydebn/config/cinnamon/spices/$SPICE/* $SPICE_DIR
    echo
  done
fi
