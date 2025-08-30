#!/bin/bash

if [ ! -f $STATE_FILE ]; then
  display "cat" "Configuring alttab switcher"
  gsettings set org.cinnamon alttab-switcher-style 'icons+preview'
  gsettings set org.cinnamon alttab-switcher-show-all-workspaces true
fi
