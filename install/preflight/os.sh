#!/bin/bash

# Check if running on supported OS
if [ -f /etc/os-release ]; then
  . /etc/os-release
  OS=$ID
  VERSION=$VERSION_ID
else
  ~/.local/share/ohmydebn/bin/ohmydebn-headline "cat" "Cannot detect OS. Exiting!"
  exit 1
fi

# Check for supported distributions
if [ "$OS" = "debian" ] && grep -q "13 (trixie)" /etc/os-release; then
  echo "Detected Debian 13 (trixie) - Supported"
elif [ "$OS" = "linuxmint" ]; then
  echo "Detected Linux Mint - Supported"
  # Check if it's a supported Ubuntu base
  if [ -n "$UBUNTU_CODENAME" ]; then
    case "$UBUNTU_CODENAME" in
      "jammy"|"noble"|"mantic")
        echo "Detected Ubuntu base: $UBUNTU_CODENAME - Supported"
        ;;
      *)
        ~/.local/share/ohmydebn/bin/ohmydebn-headline "cat" "Linux Mint with unsupported Ubuntu base ($UBUNTU_CODENAME). Exiting!"
        exit 1
        ;;
    esac
  else
    ~/.local/share/ohmydebn/bin/ohmydebn-headline "cat" "Cannot detect Ubuntu base for Linux Mint. Exiting!"
    exit 1
  fi
else
  ~/.local/share/ohmydebn/bin/ohmydebn-headline "cat" "OhMyDebn is designed for Debian 13 Cinnamon or Linux Mint. Exiting!"
  exit 1
fi
