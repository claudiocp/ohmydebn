#!/bin/bash

if [ ! -f ~/.local/state/ohmydebn ]; then
  display "cat" "Configuring cinnamon spices"
  for SPICE in "workspace-switcher@cinnamon.org" "notifications@cinnamon.org" "calendar@cinnamon.org"; do
    SPICE_DIR=~/.config/cinnamon/spices/$SPICE
    mkdir -p $SPICE_DIR
    echo "Configuring $SPICE"
    cp -av ~/.local/share/ohmydebn/config/cinnamon/spices/$SPICE/* $SPICE_DIR
    echo
  done
fi
