#!/bin/bash

for FILE in ohmydebn-demo ohmydebn-demo-gui ohmydebn-keepass ohmydebn-logo ohmydebn-logo-generate ohmydebn-logo-gui \
  ohmydebn-reset-config ohmydebn-rofi-window-switcher ohmydebn-screenfetch ohmydebn-screenfetch-gui ohmydebn-show-done \
  ohmydebn-show-logo ohmydebn-theme-bg-next ohmydebn-theme-current ohmydebn-theme-install ohmydebn-theme-list \
  ohmydebn-theme-next ohmydebn-theme-remove ohmydebn-theme-set ohmydebn-theme-set-gui ohmydebn-update \
  ohmydebn-update-available ohmydebn-update-components ohmydebn-update-git ohmydebn-update-system-pkgs ohmydebn-version; do
  if [ -f /usr/local/bin/$FILE ]; then
    echo "Removing old file /usr/local/bin/$FILE"
    sudo rm -f /usr/local/bin/$FILE
  fi
done
