#!/bin/bash

if [ ! -f ~/.local/state/ohmydebn ]; then
  ~/.local/share/ohmydebn/bin/ohmydebn-headline "cat" "Configuring gedit"
  gsettings set org.gnome.gedit.preferences.editor highlight-current-line false
  gsettings set org.gnome.gedit.preferences.editor display-line-numbers false
fi
