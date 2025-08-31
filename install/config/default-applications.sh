#!/bin/bash

if [ ! -f ~/.local/state/ohmydebn ]; then
  display "cat" "Configuring alacritty as default terminal emulator"
  gsettings set org.cinnamon.desktop.default-applications.terminal exec "'alacritty'"

  display "cat" "Configuring chromium as default web browser"
  sudo update-alternatives --set x-www-browser /usr/bin/chromium
  xdg-settings set default-web-browser chromium.desktop
  xdg-mime default chromium.desktop x-scheme-handler/http
  xdg-mime default chromium.desktop x-scheme-handler/https

  display "cat" "Configuring ristretto as default image viewer"
  xdg-mime default org.xfce.ristretto.desktop image/jpeg image/png image/gif image/bmp image/tiff
fi
