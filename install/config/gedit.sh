#!/bin/bash

if [ ! -f $STATE_FILE ]; then
  display "cat" "Configuring gedit"
  gsettings set org.gnome.gedit.preferences.editor highlight-current-line false
  gsettings set org.gnome.gedit.preferences.editor display-line-numbers false
fi
