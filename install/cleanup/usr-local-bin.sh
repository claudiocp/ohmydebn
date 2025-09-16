#!/bin/bash

for FILE in ohmymint-demo ohmymint-demo-gui ohmymint-keepass ohmymint-logo ohmymint-logo-generate ohmymint-logo-gui \
  ohmymint-reset-config ohmymint-rofi-window-switcher ohmymint-screenfetch ohmymint-screenfetch-gui ohmymint-show-done \
  ohmymint-show-logo ohmymint-theme-bg-next ohmymint-theme-current ohmymint-theme-install ohmymint-theme-list \
  ohmymint-theme-next ohmymint-theme-remove ohmymint-theme-set ohmymint-theme-set-gui ohmymint-update \
  ohmymint-update-available ohmymint-update-components ohmymint-update-git ohmymint-update-system-pkgs ohmymint-version; do
  if [ -f /usr/local/bin/$FILE ]; then
    echo "Removing old file /usr/local/bin/$FILE"
    sudo rm -f /usr/local/bin/$FILE
  fi
done
