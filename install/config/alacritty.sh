#!/bin/bash

ALACRITTY_DIR=~/.config/alacritty
ALACRITTY_CONFIG=$ALACRITTY_DIR/alacritty.toml

if grep -q "alacritty/catppuccin-mocha.toml" $ALACRITTY_CONFIG >/dev/null 2>&1; then
  mv $ALACRITTY_DIR $ALACRITTY_DIR.before.themes
fi

if [ ! -d $ALACRITTY_DIR ]; then
  cp -av ~/.local/share/ohmydebn/config/alacritty ~/.config/
fi
