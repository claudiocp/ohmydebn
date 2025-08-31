#!/bin/bash

if [ ! -f ~/.local/state/ohmydebn ]; then
  display "cat" "Configuring ristretto as default image viewer"
  xdg-mime default org.xfce.ristretto.desktop image/jpeg image/png image/gif image/bmp image/tiff
fi
