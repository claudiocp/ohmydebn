#!/bin/bash

if [ ! -f ~/.local/state/ohmydebn ]; then
  ~/.local/share/ohmydebn/bin/ohmydebn-headline "cat" "Configuring alttab switcher"
  gsettings set org.cinnamon alttab-switcher-style 'icons+preview'
  gsettings set org.cinnamon alttab-switcher-show-all-workspaces true
fi
