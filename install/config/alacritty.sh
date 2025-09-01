#!/bin/bash

ALACRITTY_DIR=~/.config/alacritty
ALACRITTY_CONFIG=$ALACRITTY_DIR/alacritty.toml

if grep -q "alacritty/catppuccin-mocha.toml" $ALACRITTY_CONFIG >/dev/null 2>&1; then
  echo "<< Removing old alacritty config >>"
  mv $ALACRITTY_DIR $ALACRITTY_DIR.before.themes
fi

if [ ! -d $ALACRITTY_DIR ]; then
  echo "<< Configuring alacritty terminal emulator >>"
  cp -av ~/.local/share/ohmydebn/config/alacritty ~/.config/
fi

if [ ! -f ~/.local/state/ohmydebn ]; then
  echo "<< Configuring alacritty as default terminal emulator >>"
  gsettings set org.cinnamon.desktop.default-applications.terminal exec "'alacritty'"
fi
