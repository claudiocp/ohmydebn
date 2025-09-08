#!/bin/bash

if ! grep -q "13 (trixie)" /etc/os-release; then
  ~/.local/share/ohmydebn/bin/ohmydebn-headline "cat" "OhMyDebn is designed for Debian 13 Cinnamon. Exiting!"
  exit 1
fi
