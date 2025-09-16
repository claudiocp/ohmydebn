#!/bin/bash

DIR=~/.local/share/applications
mkdir -p $DIR
MENU=$DIR/ohmymint-menu.desktop

if [ ! -f $MENU ]; then
  cat <<EOF >>$MENU
[Desktop Entry]
Version=1.0
Name=OhMyMint Menu
Comment=OhMyMint Menu
Exec=$HOME/.local/share/ohmymint/bin/ohmymint-menu
Terminal=false
Type=Application
Icon=stock_smiley-1
StartupNotify=true
EOF
fi
