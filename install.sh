#!/bin/bash

set -e
clear
cat <<EOF
Welcome to OhMyMint!

OhMyMint is a debonair Linux Mint + Cinnamon setup inspired by Omarchy.

Debonair strides bold,
Elegance in every step,
Stars bow to its charm.
 -- AI, probably
EOF

# Detect Linux Mint distribution
if [ -f /etc/os-release ]; then
  . /etc/os-release
  OS=$ID
  VERSION=$VERSION_ID
else
  echo "Cannot detect OS. Exiting."
  exit 1
fi

# Check if running on Linux Mint
if [ "$OS" != "linuxmint" ]; then
  echo "This script is designed to work only on Linux Mint."
  echo "Detected OS: $OS"
  echo "Please run this script on a Linux Mint system."
  exit 1
fi

# Check to see if we have an APT configuration
if [ -f /etc/apt/sources.list.d/linuxmint.sources ] || [ -f /etc/apt/sources.list.d/official-package-repositories.list ]; then
  echo "Found an APT sources file in /etc/apt/sources.list.d/"
else
  # Some Linux Mint installation methods have a broken APT configuration so try to work around that
  SOURCESLIST=/etc/apt/sources.list
  if ! grep -q "linuxmint.com\|ubuntu.com" $SOURCESLIST >/dev/null 2>&1; then
    echo "$SOURCESLIST does not have any linuxmint.com or ubuntu.com references."
    if [ -f $SOURCESLIST ]; then
      echo "Renaming $SOURCESLIST to $SOURCESLIST.orig"
      sudo mv $SOURCESLIST $SOURCESLIST.orig
    fi
    
    # Configure Linux Mint repositories
    MINT_SOURCES=/etc/apt/sources.list.d/linuxmint.sources
    if [ ! -f $MINT_SOURCES ]; then
      echo "Creating $MINT_SOURCES and adding the following:"
      cat <<EOF | sudo tee -a $MINT_SOURCES
Types: deb
URIs: http://packages.linuxmint.com
Suites: $UBUNTU_CODENAME
Components: main upstream import backport

Types: deb
URIs: http://archive.ubuntu.com/ubuntu
Suites: $UBUNTU_CODENAME $UBUNTU_CODENAME-security $UBUNTU_CODENAME-updates $UBUNTU_CODENAME-backports
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
EOF
    fi
  fi
fi

if ! dpkg -s "git" >/dev/null 2>&1; then
  echo
  echo "We need to install git so that we can clone the repo and continue the install."
  echo
  sudo apt update
  sudo apt -y install git
fi

# Install and update GPG keys for repositories
echo
echo "Installing and updating GPG keys..."

echo "Installing Ubuntu/Linux Mint GPG keys..."
sudo apt -y install ubuntu-keyring
sudo apt update --allow-releaseinfo-change

# Use custom repo if specified, otherwise default to claudiocp/ohmymint
OHMYMINT_REPO="${OHMYMINT_REPO:-claudiocp/ohmydebn}"

echo -e "\nCloning OhMyMint from: https://github.com/${OHMYMINT_REPO}.git"
rm -rf ~/.local/share/ohmymint/
git clone "https://github.com/${OHMYMINT_REPO}.git" ~/.local/share/ohmymint >/dev/null

# Use custom branch if instructed
if [[ -n "$OHMYMINT_REF" ]]; then
  echo -e "\eUsing branch: $OHMYMINT_REF"
  cd ~/.local/share/ohmymint
  git fetch origin "${OHMYMINT_REF}" && git checkout "${OHMYMINT_REF}"
  cd - >/dev/null
fi

source ~/.local/share/ohmymint/ohmydebn.sh "$@"
