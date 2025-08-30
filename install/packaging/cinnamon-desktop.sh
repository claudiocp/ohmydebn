#!/bin/bash

logo
echo

display "tte waves" "Configuring base OS"
echo

if ! dpkg -s "cinnamon-desktop-environment" >/dev/null 2>&1; then
  display "cat" "Installing Cinnamon desktop"
  sudo apt -y install cinnamon-desktop-environment
fi
