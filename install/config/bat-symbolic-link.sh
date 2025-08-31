#!/bin/bash

BAT_BIN=/usr/local/bin/bat
if [ ! -e $BAT_BIN ]; then
  display "cat" "Creating symbolic link for bat"
  sudo ln -s /usr/bin/batcat /usr/local/bin/bat
fi
