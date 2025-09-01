#!/bin/bash

if [ ! -f ~/.local/state/ohmydebn ]; then
  echo "Configuring alacritty as default terminal emulator"
  gsettings set org.cinnamon.desktop.default-applications.terminal exec "'alacritty'"

  echo "Configuring chromium as default web browser"
  sudo update-alternatives --set x-www-browser /usr/bin/chromium
  xdg-settings set default-web-browser chromium.desktop
  xdg-mime default chromium.desktop x-scheme-handler/http
  xdg-mime default chromium.desktop x-scheme-handler/https

  echo "Configuring ristretto as default image viewer"
  xdg-mime default org.xfce.ristretto.desktop image/bmp image/gif image/jpeg image/png image/tiff image/webp
fi
