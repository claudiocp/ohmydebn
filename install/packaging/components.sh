#!/bin/bash

if [ ! -f $STATE_FILE ]; then
  display "tte rain" "Installing new apps if unnecessary"
  sudo DEBIAN_FRONTEND=noninteractive apt -y install alacritty bat bibata-cursor-theme binutils btop cava chromium curl eza fzf \
    git gimp golang gum gvfs-backends htop iperf3 keepassxc lazygit libnotify-bin neovim openvpn pdftk-java python-is-python3 \
    ripgrep ristretto rofi screenfetch starship systemd-timesyncd vim wget xdotool yaru-theme-gtk yaru-theme-icon yq \
    zoxide zsh zsh-autosuggestions zsh-syntax-highlighting
fi
