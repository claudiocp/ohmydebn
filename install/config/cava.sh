#!/bin/bash

if [ ! -d ~/.config/cava ]; then
  echo; echo "<< Configuring cava >>"
  cp -av ~/.local/share/ohmydebn/config/cava ~/.config/
  echo
fi
