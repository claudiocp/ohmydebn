#!/bin/bash

# Check if running on supported OS
if [ -f /etc/os-release ]; then
  . /etc/os-release
  OS=$ID
  VERSION=$VERSION_ID
else
  ~/.local/share/ohmymint/bin/ohmymint-headline "cat" "Cannot detect OS. Exiting!"
  exit 1
fi

# Check for supported distributions - only Linux Mint
if [ "$OS" = "linuxmint" ]; then
  echo "Detected Linux Mint - Supported"
  # Check if it's a supported Ubuntu base
  if [ -n "$UBUNTU_CODENAME" ]; then
    case "$UBUNTU_CODENAME" in
      "jammy"|"noble"|"mantic")
        echo "Detected Ubuntu base: $UBUNTU_CODENAME - Supported"
        ;;
      *)
        ~/.local/share/ohmymint/bin/ohmymint-headline "cat" "Linux Mint with unsupported Ubuntu base ($UBUNTU_CODENAME). Exiting!"
        exit 1
        ;;
    esac
  else
    ~/.local/share/ohmymint/bin/ohmymint-headline "cat" "Cannot detect Ubuntu base for Linux Mint. Exiting!"
    exit 1
  fi
else
  ~/.local/share/ohmymint/bin/ohmymint-headline "cat" "OhMyMint is designed for Linux Mint only. Exiting!"
  exit 1
fi
