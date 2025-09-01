#!/bin/bash

if [ ! -d ~/.config/btop ]; then
  echo "Configuring btop:"
  cp -av ~/.local/share/ohmydebn/config/btop ~/.config/
  echo
fi

BTOP_THEMES_DIR=~/.config/btop/themes
mkdir -p $BTOP_THEMES_DIR
BTOP_CURRENT_THEME=$BTOP_THEMES_DIR/current.theme
if [ ! -L $BTOP_CURRENT_THEME ]; then
  echo "Configuring btop theme"
  ln -snf ~/.config/ohmydebn/current/theme/btop.theme $BTOP_CURRENT_THEME
fi
