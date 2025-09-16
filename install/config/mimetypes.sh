#!/bin/bash

if [ ! -f ~/.local/state/ohmymint ]; then
  ~/.local/share/ohmymint/bin/ohmymint-headline "cat" "Configuring chromium as default web browser"
  sudo update-alternatives --set x-www-browser /usr/bin/chromium
  xdg-settings set default-web-browser chromium.desktop
  xdg-mime default chromium.desktop x-scheme-handler/http
  xdg-mime default chromium.desktop x-scheme-handler/https

  ~/.local/share/ohmymint/bin/ohmymint-headline "cat" "Configuring ristretto as default image viewer"
  xdg-mime default org.xfce.ristretto.desktop image/bmp image/gif image/jpeg image/png image/tiff image/webp
fi
