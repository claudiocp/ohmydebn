#!/bin/bash

if [ $(dpkg -l | grep "^ii  mint-" | wc -l) -eq 0 ]; then
  display "cat" "Downloading Cinnamon themes"
  MINTLIST="/etc/apt/sources.list.d/mint.list"
  MINTKEY="linuxmint-keyring_2022.06.21_all.deb"
  MINTURL="http://packages.linuxmint.com/pool/main/l/linuxmint-keyring/$MINTKEY"
  echo
  echo "Temporarily adding the following repo:"
  echo
  echo "deb http://packages.linuxmint.com virginia main" | sudo tee -a $MINTLIST
  curl -O $MINTURL
  echo
  sudo dpkg -i $MINTKEY
  echo
  sudo rm -f $MINTKEY
  sudo apt update && sudo apt -y install mint-themes mint-x-icons mint-y-icons
  echo
  sudo rm -f $MINTLIST
  sudo apt update
  echo
  sudo apt -y purge linuxmint-keyring
fi
