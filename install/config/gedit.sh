#!/bin/bash

STATE_DIR=~/.local/state/ohmymint-config
GEDIT_STATE=$STATE_DIR/gedit

if [ ! -f $GEDIT_STATE ]; then

  ~/.local/share/ohmymint/bin/ohmymint-headline "cat" "Configuring gedit"
  gsettings set org.gnome.gedit.preferences.editor highlight-current-line false
  gsettings set org.gnome.gedit.preferences.editor display-line-numbers false
  gsettings set org.gnome.gedit.preferences.ui theme-variant 'light'
  mkdir -p $STATE_DIR
  touch $GEDIT_STATE

fi
