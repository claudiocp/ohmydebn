#!/bin/bash

~/.local/share/ohmydebn/bin/ohmydebn-headline "tte rain" "Installing new apps if unnecessary"

# Detect OS to adjust package list
if [ -f /etc/os-release ]; then
  . /etc/os-release
  OS=$ID
else
  OS="debian"
fi

# Base packages common to both Debian and Linux Mint
BASE_PACKAGES="alacritty \
  bat \
  binutils \
  btop \
  cava \
  chromium \
  curl \
  eza \
  ffmpeg \
  fzf \
  galculator \
  gcolor3 \
  git \
  gimp \
  golang \
  gum \
  gvfs-backends \
  htop \
  iperf3 \
  keepassxc \
  lazygit \
  libnotify-bin \
  lshw \
  neovim \
  openvpn \
  pdftk-java \
  python-is-python3 \
  ripgrep \
  ristretto \
  rofi \
  screenfetch \
  shellcheck \
  starship \
  systemd-timesyncd \
  ufw \
  vim \
  wget \
  xdotool \
  yq \
  zoxide \
  zsh \
  zsh-autosuggestions \
  zsh-syntax-highlighting"

# OS-specific packages
if [ "$OS" = "linuxmint" ]; then
  # Linux Mint specific packages
  MINT_PACKAGES="bibata-cursor-theme"
  PACKAGES="$BASE_PACKAGES $MINT_PACKAGES"
else
  # Debian specific packages
  DEBIAN_PACKAGES="bibata-cursor-theme yaru-theme-gtk yaru-theme-icon"
  PACKAGES="$BASE_PACKAGES $DEBIAN_PACKAGES"
fi

sudo DEBIAN_FRONTEND=noninteractive apt -y install $PACKAGES
