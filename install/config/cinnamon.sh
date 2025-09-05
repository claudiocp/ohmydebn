#!/bin/bash

if [ ! -f ~/.local/state/ohmydebn ]; then

  ~/.local/share/ohmydebn/bin/ohmydebn-headline "cat" "Configuring Cinnamon alttab switcher"
  gsettings set org.cinnamon alttab-switcher-style 'icons+preview'
  gsettings set org.cinnamon alttab-switcher-show-all-workspaces true

  ~/.local/share/ohmydebn/bin/ohmydebn-headline "cat" "Setting Cinnamon window effect speed to maximum"
  gsettings set org.cinnamon window-effect-speed 2

  if gsettings get org.cinnamon enabled-applets | grep -q grouped-window-list; then
    ~/.local/share/ohmydebn/bin/ohmydebn-headline "cat" "Changing Cinnamon grouped window list to window list"
    gsettings set org.cinnamon enabled-applets "$(gsettings get org.cinnamon enabled-applets | sed "s/panel1:left:[0-9]*:grouped-window-list@cinnamon.org:[0-9]*/panel1:left:1:window-list@cinnamon.org:12/")"
  fi

  if ! gsettings get org.cinnamon enabled-applets | grep -q workspace-switcher; then
    ~/.local/share/ohmydebn/bin/ohmydebn-headline "cat" "Enabling Cinnamon workspace switcher"
    gsettings set org.cinnamon enabled-applets "$(gsettings get org.cinnamon enabled-applets | sed 's/]$/, "panel1:right:0:workspace-switcher@cinnamon.org:10"]/')"
  fi

  ~/.local/share/ohmydebn/bin/ohmydebn-headline "cat" "Configuring Cinnamon spices"
  for SPICE in "workspace-switcher@cinnamon.org" "notifications@cinnamon.org" "calendar@cinnamon.org"; do
    SPICE_DIR=~/.config/cinnamon/spices/$SPICE
    mkdir -p $SPICE_DIR
    ~/.local/share/ohmydebn/bin/ohmydebn-headline "cat" "Configuring Cinnamon spice $SPICE"
    cp -av ~/.local/share/ohmydebn/config/cinnamon/spices/$SPICE/* $SPICE_DIR
    echo
  done

fi

PANEL_STATE=~/.local/state/ohmydebn-panel
if [ ! -f $PANEL_STATE ]; then
  ~/.local/share/ohmydebn/bin/ohmydebn-headline "cat" "Configuring panel to be at top of screen"
  gsettings set org.cinnamon panels-enabled-panels "['1:0:top']"
  mkdir -p ~/.local/state
  touch $PANEL_STATE
fi
