#!/bin/bash

KEYBINDING_CINNAMON=~/.local/share/ohmydebn/install/keybinding-cinnamon.txt
KEYBINDING_CUSTOM=~/.local/share/ohmydebn/install/keybinding-custom.txt

function keybinding-cinnamon (
  echo $3
  CMD="gsettings set org.cinnamon.desktop.keybindings.wm $1 \"$2\""
  eval $CMD
)

function keybinding-custom (
  echo $5
  GSETTINGS1="gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-$1/ name \"$2\""
  GSETTINGS2="gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-$1/ command \"$3\""
  GSETTINGS3="gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-$1/ binding \"$4\""
  eval $GSETTINGS1
  eval $GSETTINGS2
  eval $GSETTINGS3
)

# Modify existing cinnamon keybindings
source $KEYBINDING_CINNAMON

# To create new custom keybindings, first specify how many custom keybindings we're going to load
CUSTOM_KEYBINDING_TOTAL=$(cat $KEYBINDING_CUSTOM | wc -l)
let CUSTOM_KEYBINDING_TOTAL--
CUSTOM_LIST="gsettings set org.cinnamon.desktop.keybindings custom-list \"["
for i in $(seq 0 $CUSTOM_KEYBINDING_TOTAL); do 
  CUSTOM_LIST+="'custom-$i'"
  if [ "$i" != "$CUSTOM_KEYBINDING_TOTAL" ]; then
    CUSTOM_LIST+=", "
  else
    CUSTOM_LIST+="]\""
  fi
done
eval $CUSTOM_LIST

# Now we can iterate through the list of custom keybindings
source $KEYBINDING_CUSTOM

# Apply keybindings
if pgrep -x cinnamon >/dev/null; then
  echo
  echo "Restarting desktop to apply hotkey configuration"
  sleep 1s
  /usr/bin/cinnamon --replace >/dev/null 2>&1 &
  sleep 1s
  echo
  echo "You can see all hotkeys by pressing Super + K"
fi
