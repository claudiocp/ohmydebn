#!/bin/bash

set -e
clear
cat <<EOF
Welcome to OhMyDebn!

OhMyDebn is a debonair Debian + Cinnamon setup inspired by Omarchy.

Debonair strides bold,
Elegance in every step,
Stars bow to its charm.
 -- AI, probably
EOF

# Detect Linux distribution
if [ -f /etc/os-release ]; then
  . /etc/os-release
  OS=$ID
  VERSION=$VERSION_ID
else
  echo "Cannot detect OS. Exiting."
  exit 1
fi

# Check to see if we have an APT configuration
if [ -f /etc/apt/sources.list.d/debian.sources ] || [ -f /etc/apt/sources.list.d/proxmox.sources ] || [ -f /etc/apt/sources.list.d/official-package-repositories.list ]; then
  echo "Found an APT sources file in /etc/apt/sources.list.d/"
else
  # Some Debian installation methods have a broken APT configuration so try to work around that
  SOURCESLIST=/etc/apt/sources.list
  if ! grep -q "debian.org\|linuxmint.com" $SOURCESLIST >/dev/null 2>&1; then
    echo "$SOURCESLIST does not have any debian.org or linuxmint.com references."
    if [ -f $SOURCESLIST ]; then
      echo "Renaming $SOURCESLIST to $SOURCESLIST.orig"
      sudo mv $SOURCESLIST $SOURCESLIST.orig
    fi
    
    if [ "$OS" = "linuxmint" ]; then
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
    else
      # Configure Debian repositories (original behavior)
      DEBIANSOURCES=/etc/apt/sources.list.d/debian.sources
      if [ ! -f $DEBIANSOURCES ]; then
        echo "Creating $DEBIANSOURCES and adding the following:"
        cat <<EOF | sudo tee -a $DEBIANSOURCES
Types: deb
URIs: https://deb.debian.org/debian
Suites: trixie trixie-updates
Components: main non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

Types: deb
URIs: https://security.debian.org/debian-security
Suites: trixie-security
Components: main non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
EOF
      fi
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

if [ "$OS" = "debian" ]; then
  echo "Installing Debian GPG keys..."
  sudo apt -y install debian-archive-keyring
  # Try modern method first, fallback to legacy if needed
  if command -v apt-key >/dev/null 2>&1; then
    sudo apt-key update
  else
    echo "apt-key not available, using alternative method..."
    sudo apt update --allow-releaseinfo-change
  fi
elif [ "$OS" = "linuxmint" ]; then
  echo "Installing Ubuntu/Linux Mint GPG keys..."
  sudo apt -y install ubuntu-keyring
  sudo apt update --allow-releaseinfo-change
fi

# Use custom repo if specified, otherwise default to claudiocp/ohmydebn
OHMYDEBN_REPO="${OHMYDEBN_REPO:-claudiocp/ohmydebn}"

echo -e "\nCloning OhMyDebn from: https://github.com/${OHMYDEBN_REPO}.git"
rm -rf ~/.local/share/ohmydebn/
git clone "https://github.com/${OHMYDEBN_REPO}.git" ~/.local/share/ohmydebn >/dev/null

# Use custom branch if instructed
if [[ -n "$OHMYDEBN_REF" ]]; then
  echo -e "\eUsing branch: $OHMYDEBN_REF"
  cd ~/.local/share/ohmydebn
  git fetch origin "${OHMYDEBN_REF}" && git checkout "${OHMYDEBN_REF}"
  cd - >/dev/null
fi

source ~/.local/share/ohmydebn/ohmydebn.sh "$@"
