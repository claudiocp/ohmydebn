#!/bin/bash

if [ ! -f ~/.local/state/ohmydebn ]; then
  toilet -f mono12 "OhMyDebn" | tte rain
  echo

  ~/.local/share/ohmydebn/bin/ohmydebn-headline "tte rain" "Configuring base OS"

  if ! dpkg -s "cinnamon-desktop-environment" >/dev/null 2>&1; then
    ~/.local/share/ohmydebn/bin/ohmydebn-headline "cat" "Installing Cinnamon desktop"
    sudo apt -y install cinnamon-desktop-environment
  fi

  # Check if we're on Linux Mint or if mint themes are not installed
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
  else
    OS="debian"
  fi

  if [ "$OS" != "linuxmint" ] && [ $(dpkg -l | grep "^ii  mint-" | wc -l) -eq 0 ]; then
    ~/.local/share/ohmydebn/bin/ohmydebn-headline "cat" "Downloading Cinnamon themes"
    ARCH=$(uname -m)
    if [ "$ARCH" != "x86_64" ]; then
      sudo dpkg --add-architecture amd64
    fi
    MINTLIST="/etc/apt/sources.list.d/mint.list"
    MINTKEY="linuxmint-keyring_2022.06.21_all.deb"
    MINTURL="http://packages.linuxmint.com/pool/main/l/linuxmint-keyring/$MINTKEY"
    echo
    echo "Temporarily adding the following repo:"
    echo
    echo "deb [arch=amd64] http://packages.linuxmint.com virginia main" | sudo tee -a $MINTLIST
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
  elif [ "$OS" = "linuxmint" ]; then
    ~/.local/share/ohmydebn/bin/ohmydebn-headline "cat" "Linux Mint detected - themes should already be available"
  fi
fi
