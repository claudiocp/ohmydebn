#!/bin/bash

if [ ! -d ~/.config/btop ]; then
  ~/.local/share/ohmymint/bin/ohmymint-headline "cat" "Configuring btop"
  cp -av ~/.local/share/ohmymint/config/btop ~/.config/
  echo
fi

BTOP_THEMES_DIR=~/.config/btop/themes
mkdir -p $BTOP_THEMES_DIR
BTOP_CURRENT_THEME=$BTOP_THEMES_DIR/current.theme
if [ ! -L $BTOP_CURRENT_THEME ]; then
  ~/.local/share/ohmymint/bin/ohmymint-headline "cat" "Configuring btop theme"
  ln -snf ~/.config/ohmymint/current/theme/btop.theme $BTOP_CURRENT_THEME
fi
