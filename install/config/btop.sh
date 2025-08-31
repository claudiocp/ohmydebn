#!/bin/bash

BTOP_THEMES_DIR=~/.config/btop/themes
mkdir -p $BTOP_THEMES_DIR
BTOP_CURRENT_THEME=$BTOP_THEMES_DIR/current.theme
if [ ! -L $BTOP_CURRENT_THEME ]; then
  display "cat" "Configuring btop theme"
  ln -snf ~/.config/$PROJECT_LOWER/current/theme/btop.theme $BTOP_CURRENT_THEME
fi
