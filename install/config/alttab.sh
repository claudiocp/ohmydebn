#!/bin/bash

if [ ! -f ~/.local/state/ohmydebn ]; then
  display "cat" "Configuring alttab switcher"
  gsettings set org.cinnamon alttab-switcher-style 'icons+preview'
  gsettings set org.cinnamon alttab-switcher-show-all-workspaces true
fi
