#!/bin/bash

OHMYMINT_INSTALL=~/.local/share/ohmymint/install

# Preflight
source $OHMYMINT_INSTALL/preflight/set.sh
source $OHMYMINT_INSTALL/preflight/os.sh
source $OHMYMINT_INSTALL/preflight/user.sh
source $OHMYMINT_INSTALL/preflight/arguments.sh
source $OHMYMINT_INSTALL/preflight/warning.sh
source $OHMYMINT_INSTALL/preflight/path.sh
source $OHMYMINT_INSTALL/preflight/effects.sh

# Packaging
source $OHMYMINT_INSTALL/packaging/cinnamon.sh
source $OHMYMINT_INSTALL/packaging/dbus.sh
source $OHMYMINT_INSTALL/packaging/components.sh
source $OHMYMINT_INSTALL/packaging/remove.sh

# Config
source $OHMYMINT_INSTALL/config/alacritty.sh
source $OHMYMINT_INSTALL/config/bat.sh
source $OHMYMINT_INSTALL/config/btop.sh
source $OHMYMINT_INSTALL/config/caskaydia.sh
source $OHMYMINT_INSTALL/config/cava.sh
source $OHMYMINT_INSTALL/config/chromium.sh
source $OHMYMINT_INSTALL/config/cinnamon.sh
source $OHMYMINT_INSTALL/config/cursor.sh
source $OHMYMINT_INSTALL/config/gedit.sh
source $OHMYMINT_INSTALL/config/git.sh
source $OHMYMINT_INSTALL/config/keepassxc.sh
source $OHMYMINT_INSTALL/config/logo.sh
source $OHMYMINT_INSTALL/config/menu.sh
source $OHMYMINT_INSTALL/config/mimetypes.sh
source $OHMYMINT_INSTALL/config/nvim.sh
source $OHMYMINT_INSTALL/config/ohmyzsh.sh
source $OHMYMINT_INSTALL/config/rofi.sh
source $OHMYMINT_INSTALL/config/theme.sh
source $OHMYMINT_INSTALL/config/ufw.sh
source $OHMYMINT_INSTALL/config/zsh.sh

# Cleanup
source $OHMYMINT_INSTALL/cleanup/usr-local-bin.sh
source $OHMYMINT_INSTALL/cleanup/theme-symlink.sh

# Finalization
source $OHMYMINT_INSTALL/finalization/updates.sh
source $OHMYMINT_INSTALL/finalization/hotkeys.sh
source $OHMYMINT_INSTALL/finalization/lightdm.sh
source $OHMYMINT_INSTALL/finalization/finale.sh
