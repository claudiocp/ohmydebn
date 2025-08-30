#!/bin/bash

OHMYDEBN_INSTALL=~/.local/share/ohmydebn/install

# Preflight
source $OHMYDEBN_INSTALL/preflight/set.sh
source $OHMYDEBN_INSTALL/preflight/functions.sh
source $OHMYDEBN_INSTALL/preflight/os.sh
source $OHMYDEBN_INSTALL/preflight/user.sh
source $OHMYDEBN_INSTALL/preflight/arguments.sh
source $OHMYDEBN_INSTALL/preflight/warning.sh
source $OHMYDEBN_INSTALL/preflight/variables.sh
source $OHMYDEBN_INSTALL/preflight/effects.sh

# Packaging
source $OHMYDEBN_INSTALL/packaging/cinnamon-desktop.sh
source $OHMYDEBN_INSTALL/packaging/cinnamon-themes.sh
source $OHMYDEBN_INSTALL/packaging/dbus-x11.sh
source $OHMYDEBN_INSTALL/packaging/components.sh
source $OHMYDEBN_INSTALL/packaging/remove.sh

# Config
source $OHMYDEBN_INSTALL/config/theme.sh
source $OHMYDEBN_INSTALL/config/alttab.sh
source $OHMYDEBN_INSTALL/config/gedit.sh
source $OHMYDEBN_INSTALL/config/cinnamon-applets.sh
source $OHMYDEBN_INSTALL/config/cinnamon-spices.sh
source $OHMYDEBN_INSTALL/config/cursor-theme.sh
source $OHMYDEBN_INSTALL/config/terminal-emulator.sh
source $OHMYDEBN_INSTALL/config/image-viewer.sh

# Cleanup
source $OHMYDEBN_INSTALL/cleanup/usr-local-bin.sh
source $OHMYDEBN_INSTALL/cleanup/theme-symlink.sh

if [ ! -f ~/.local/share/fonts/CaskaydiaMonoNerdFont-Regular.ttf ]; then
  display "cat" "Configuring alacritty with Caskyadia Nerd Font"
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/CascadiaMono.zip
  unzip CascadiaMono.zip -d ~/.local/share/fonts
  rm -f CascadiaMono.zip
  fc-cache -fv
fi

BAT_BIN=/usr/local/bin/bat
if [ ! -e $BAT_BIN ]; then
  display "cat" "Creating symbolic link for bat"
  sudo ln -s /usr/bin/batcat /usr/local/bin/bat
fi

ALACRITTY_DIR=~/.config/alacritty
ALACRITTY_CONFIG=$ALACRITTY_DIR/alacritty.toml
if grep -q "alacritty/catppuccin-mocha.toml" $ALACRITTY_CONFIG >/dev/null 2>&1; then
  mv $ALACRITTY_DIR $ALACRITTY_DIR.before.themes
fi

display "cat" "Configuring components"
for COMPONENT in alacritty bat btop cava chromium keepassxc rofi; do
  COMPONENT_CONFIG_DIR=~/.config/$COMPONENT
  if [ ! -d $COMPONENT_CONFIG_DIR ]; then
    echo "Configuring $COMPONENT:"
    cp -av ~/.local/share/$PROJECT_LOWER/config/$COMPONENT ~/.config/
    echo
  fi
done

BAT_CACHE_METADATA=~/.cache/bat/metadata.yaml
if [ ! -f $BAT_CACHE_METADATA ]; then
  display "cat" "Building cache for bat"
  bat cache --build
fi

BTOP_THEMES_DIR=~/.config/btop/themes
mkdir -p $BTOP_THEMES_DIR
BTOP_CURRENT_THEME=$BTOP_THEMES_DIR/current.theme
if [ ! -L $BTOP_CURRENT_THEME ]; then
  display "cat" "Configuring btop theme"
  ln -snf ~/.config/$PROJECT_LOWER/current/theme/btop.theme $BTOP_CURRENT_THEME
fi

NVIM_CONFIG_DIR=~/.config/nvim
if [ ! -d $NVIM_CONFIG_DIR ]; then
  display "cat" "Configuring neovim with lazyvim"
  git clone https://github.com/LazyVim/starter $NVIM_CONFIG_DIR
  rm -rf $NVIM_CONFIG_DIR/.git
fi
NVIM_PLUGINS=$NVIM_CONFIG_DIR/lua/plugins
mkdir -p $NVIM_PLUGINS
if grep -q "colorscheme = \"catppuccin\"" $NVIM_PLUGINS/core.lua >/dev/null 2>&1; then
  display "cat" "Disabling old static neovim theme config"
  mv $NVIM_PLUGINS/core.lua $NVIM_PLUGINS/core.lua.disabled
fi
NVIM_THEME=$NVIM_PLUGINS/theme.lua
if [ ! -L $NVIM_THEME ]; then
  display "cat" "Configuring neovim theme"
  ln -snf ~/.config/$PROJECT_LOWER/current/theme/neovim.lua $NVIM_THEME
fi
display "cat" "Updating neovim config"
cp -av ~/.local/share/$PROJECT_LOWER/config/nvim ~/.config/

OHMYZSH_DIR=~/.oh-my-zsh
if [ ! -d $OHMYZSH_DIR ]; then
  display "cat" "Installing Oh My Zsh framework for Zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  mv ~/.zshrc ~/.zshrc.oh-my-zsh
fi

STARSHIP_CONFIG=~/config/starship.toml
if [ ! -f $STARSHIP_CONFIG ]; then
  display "cat" "Configuring starship prompt"
  cp ~/.local/share/$PROJECT_LOWER/config/starship.toml ~/.config/
fi

ZSH_CONFIG=~/.zshrc
if [ ! -f $ZSH_CONFIG ]; then
  display "cat" "Configuring Zsh"
  cp ~/.local/share/$PROJECT_LOWER/config/.zshrc ~/
fi

~/.local/share/$PROJECT_LOWER/bin/ohmydebn-logo-generate
source $OHMYDEBN_INSTALL/path.sh

if [ ! -f $STATE_FILE ]; then
  display "cat" "Setting theme"
  mkdir -p ~/.config/$PROJECT_LOWER/current
  ~/.local/share/ohmydebn/bin/ohmydebn-theme-set Ohmydebn
fi

display "tte rain" "Installing any available OS updates"
sudo apt -y dist-upgrade

display "tte rain" "Updating hotkeys"
source $OHMYDEBN_INSTALL/keybinding/keybinding.sh

if [ -f $STATE_FILE ]; then
  echo
  echo "Update complete!"
else
  display "tte rain" "Installation complete!"
  echo
  screenfetch -N | tte slide --merge
  echo
  welcome
  # Create a state file signifying that installation is complete
  touch $STATE_FILE
fi
