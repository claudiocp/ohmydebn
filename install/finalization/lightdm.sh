#!/bin/bash

LIGHTDM_CONF=/etc/lightdm/lightdm.conf
if grep "rpd-labwc" $LIGHTDM_CONF >/dev/null 2>&1; then
  ~/.local/share/ohmymint/bin/ohmymint-headline "tte rain" "Updating $LIGHTDM_CONF use log into cinnamon desktop"
  echo "Once installation is complete, you will neeed to reboot to make this change take effect."
  sudo sed -i.BEFORE.OHMYDEBN 's|rpd-labwc|cinnamon|g' $LIGHTDM_CONF
fi
