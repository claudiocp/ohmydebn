#!/bin/bash

MENU=~/.local/share/applications/ohmydebn-menu.desktop

if [ ! -f $MENU ]; then
  cat << EOF >> $MENU
[Desktop Entry]
Version=1.0
Name=OhMyDebn Menu
Comment=OhMyDebn Menu
Exec=~/.local/share/ohmydebn/bin/ohmydebn-menu
Terminal=false
Type=Application
Icon=stock_smiley_1
StartupNotify=true
EOF
