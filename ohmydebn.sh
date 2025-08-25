#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

PROJECT="OhMyDebn"
PROJECT_LOWER=$(echo "$PROJECT" | tr '[:upper:]' '[:lower:]')
STATE_FILE=~/.local/state/$PROJECT_LOWER

# Parse command line arguments
NO_UNINSTALL=false
for arg in "$@"; do
  case $arg in
  --no-uninstall)
    NO_UNINSTALL=true
    shift
    ;;
  *)
    # Unknown option
    ;;
  esac
done

function logo {
  toilet -f mono12 "$PROJECT" | tte rain
}

function welcome {
  toilet -f mono12 "Welcome" | tte rain
  toilet -f mono12 "   to" | tte rain
  logo
}

function display {
  echo
  if [ ! -f $STATE_FILE ]; then
    # For first installation, use text effects
    PROCESSOR=$1
  else
    # For updates, don't use text effects
    PROCESSOR=cat
  fi
  cat <<EOF | $1
###############################################################################
$2
###############################################################################
EOF
  echo
}

if ! grep -q "13 (trixie)" /etc/os-release; then
  display "cat" "This script is designed for Debian 13 Cinnamon. Exiting!"
  exit 1
fi

if [ "$UID" -eq 0 ]; then

  display "cat" "Looks like you're running as root.
 
Instead of running as root, you most likely want to 
run this script as a normal user that has sudo privileges.

Press Enter if you are sure you want to continue as root
or Ctrl-c to cancel."

  read input
fi

if [ ! -f $STATE_FILE ]; then
  display "cat" "WARNING!

This script:
- is intended for a clean new installation.
$(if [ "$NO_UNINSTALL" = false ]; then echo "- will remove apps like FireFox, Thunderbird, and others."; else echo "- will NOT remove any existing packages (--no-uninstall mode)."; fi)
- may make changes to your APT configuration.

This script is totally unsupported. 
If it breaks your system, you get to keep both pieces!

Press Enter to continue or Ctrl-c to cancel."
  read input
fi

if [ -f /etc/apt/sources.list.d/debian.sources ] || [ -f /etc/apt/sources.list.d/proxmox.sources ]; then
  echo "Found an APT sources file in /etc/apt/sources.list.d/"
else
  SOURCESLIST=/etc/apt/sources.list
  if ! grep -q "debian.org" $SOURCESLIST >/dev/null 2>&1; then
    display "cat" "$SOURCESLIST does not have any debian.org references."
    if [ -f $SOURCESLIST ]; then
      echo "Renaming $SOURCESLIST to $SOURCESLIST.orig"
      sudo mv $SOURCESLIST $SOURCESLIST.orig
    fi
    DEBIANSOURCES=/etc/apt/sources.list.d/debian.sources
    if [ ! -f $DEBIANSOURCES ]; then
      echo "$DEBIANSOURCES does not exist."
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

if ! dpkg -s curl >/dev/null 2>&1 ||
  ! dpkg -s libglib2.0-bin >/dev/null 2>&1 ||
  ! dpkg -s python3-terminaltexteffects >/dev/null 2>&1 ||
  ! dpkg -s toilet >/dev/null 2>&1 ||
  ! dpkg -s toilet-fonts >/dev/null 2>&1; then
  display "cat" "Installing text effects for demoscene nostalgia"
  sudo apt update && sudo apt -y install curl libglib2.0-bin python3-terminaltexteffects toilet toilet-fonts
  # Most users are running a normal Debian 13 Cinnamon desktop and are running this script via gnome-terminal
  # In that case, let's change some terminal settings to make the output of this script look nicer
  if dpkg -s "gnome-terminal" >/dev/null 2>&1; then
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ foreground-color "'#D3D7CF'"
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ background-color "'#2E3436'"
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ use-theme-colors false
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ palette "['#2e3436', '#cc0000', '#4e9a06', '#c4a000', '#3465a4', '#75507b', '#06989a', '#d3d7cf', '#555753', '#ef2929', '#8ae234', '#fce94f', '#729fcf', '#ad7fa8', '#34e2e2', '#eeeeec']"
  fi
fi

logo
echo

display "tte waves" "Configuring base OS"
echo

if ! dpkg -s "cinnamon-desktop-environment" >/dev/null 2>&1; then
  display "cat" "Installing Cinnamon desktop"
  sudo apt -y install cinnamon-desktop-environment
fi

if [ $(dpkg -l | grep "^ii  mint-" | wc -l) -eq 0 ]; then
  display "cat" "Downloading Cinnamon themes"
  MINTLIST="/etc/apt/sources.list.d/mint.list"
  MINTKEY="linuxmint-keyring_2022.06.21_all.deb"
  MINTURL="http://packages.linuxmint.com/pool/main/l/linuxmint-keyring/$MINTKEY"
  echo
  echo "Temporarily adding the following repo:"
  echo
  echo "deb http://packages.linuxmint.com virginia main" | sudo tee -a $MINTLIST
  curl -O $MINTURL
  echo
  sudo dpkg -i $MINTKEY
  echo
  sudo rm -f $MINTKEY
  sudo apt update && sudo apt -y install mint-themes mint-x-icons mint-y-icons
  echo
  sudo rm -f $MINTLIST
  sudo apt update
  echo
  sudo apt -y purge linuxmint-keyring
fi

if [ -f /usr/bin/pveversion ]; then
  display "cat" "Installing dbus-x11"
  sudo apt -y install dbus-x11
  export $(dbus-launch)
fi

display "cat" "Updating themes"
if [ ! -d ~/.local/share/omarchy ]; then
  cd ~/.local/share/
  git clone https://github.com/basecamp/omarchy.git
else
  cd ~/.local/share/omarchy
  git pull
fi
cd - >/dev/null

display "cat" "Changing desktop wallpaper"
mkdir -p ~/.config/$PROJECT_LOWER/themes
for f in ~/.local/share/$PROJECT_LOWER/themes/*; do
  THEME=$(basename $f)
  if [ ! -L ~/.config/$PROJECT_LOWER/themes/$THEME ]; then
    ln -nfs "$f" ~/.config/$PROJECT_LOWER/themes/
  fi
done
for f in ~/.local/share/omarchy/themes/*; do
  THEME=$(basename $f)
  if [ ! -L ~/.config/omarchy/themes/$THEME ]; then
    ln -nfs "$f" ~/.config/$PROJECT_LOWER/themes/
  fi
done
# Set initial theme
mkdir -p ~/.config/$PROJECT_LOWER/current
if [ ! -L ~/.config/$PROJECT_LOWER/current/theme ]; then
  ln -snf ~/.config/$PROJECT_LOWER/themes/$PROJECT_LOWER ~/.config/$PROJECT_LOWER/current/theme
fi
if [ ! -L ~/.config/$PROJECT_LOWER/current/background ]; then
  ln -snf ~/.config/$PROJECT_LOWER/current/theme/backgrounds/salty_mountains.png ~/.config/$PROJECT_LOWER/current/background
fi

# Some installs might have an incorrect symlink
# if the old symlink exists, then remove it
OLD_SYMLINK=~/.local/share/$PROJECT_LOWER/themes/$PROJECT_LOWER/$PROJECT_LOWER
if [ -L $OLD_SYMLINK ]; then
  echo "Removing old symlink $OLD_SYMLINK"
  rm -f $OLD_SYMLINK
fi

BACKGROUND=~/.config/$PROJECT_LOWER/current/background
gsettings set org.cinnamon.desktop.background picture-uri "'file://$BACKGROUND'"

display "cat" "Setting Cinnamon theme"
gsettings set org.cinnamon.theme name "'Mint-Y-Dark-Aqua'"

display "cat" "Setting cursor theme"
sudo apt -y install bibata-cursor-theme
gsettings set org.cinnamon.desktop.interface cursor-theme "'Bibata-Modern-Classic'"

display "cat" "Setting GTK theme"
gsettings set org.cinnamon.desktop.interface gtk-theme "'Mint-Y-Dark-Aqua'"

display "cat" "Setting icon theme"
gsettings set org.cinnamon.desktop.interface icon-theme "'Mint-Y-Sand'"

display "cat" "Setting alttab switcher style to icons+preview"
gsettings set org.cinnamon alttab-switcher-style 'icons+preview'

display "cat" "Configuring alttab switcher for all workspaces"
gsettings set org.cinnamon alttab-switcher-show-all-workspaces true

display "cat" "Configuring gedit"
gsettings set org.gnome.gedit.preferences.editor highlight-current-line false
gsettings set org.gnome.gedit.preferences.editor display-line-numbers false

if gsettings get org.cinnamon enabled-applets | grep -q grouped-window-list; then
  display "cat" "Changing grouped window list to window list"
  gsettings set org.cinnamon enabled-applets "$(gsettings get org.cinnamon enabled-applets | sed "s/panel1:left:[0-9]*:grouped-window-list@cinnamon.org:[0-9]*/panel1:left:1:window-list@cinnamon.org:12/")"
fi

if ! gsettings get org.cinnamon enabled-applets | grep -q workspace-switcher; then
  display "cat" "Enabling workspace switcher"
  gsettings set org.cinnamon enabled-applets "$(gsettings get org.cinnamon enabled-applets | sed 's/]$/, "panel1:right:0:workspace-switcher@cinnamon.org:10"]/')"
fi

display "cat" "Configuring cinnamon spices"
for SPICE in "workspace-switcher@cinnamon.org" "notifications@cinnamon.org"; do
  SPICE_DIR=~/.config/cinnamon/spices/$SPICE
  mkdir -p $SPICE_DIR
  echo "Configuring $SPICE"
  cp -av ~/.local/share/$PROJECT_LOWER/config/cinnamon/spices/$SPICE/* $SPICE_DIR
  echo
done

display "tte rain" "Installing new apps if unnecessary and configuring them"
sudo DEBIAN_FRONTEND=noninteractive apt -y install alacritty bat binutils btop cava chromium curl eza fzf git gimp golang gvfs-backends htop iperf3 keepassxc neovim openvpn pdftk-java python-is-python3 ripgrep ristretto rofi screenfetch starship systemd-timesyncd vim wget xdotool yq zoxide zsh zsh-autosuggestions zsh-syntax-highlighting

display "cat" "Setting alacritty as default terminal emulator"
gsettings set org.cinnamon.desktop.default-applications.terminal exec "'alacritty'"

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

display "cat" "Copying binaries to /usr/local/bin/"
sudo cp -av ~/.local/share/$PROJECT_LOWER/bin/* /usr/local/bin/
sudo chmod +x /usr/local/bin/$PROJECT_LOWER*

display "cat" "Configuring ristretto as default image viewer"
xdg-mime default org.xfce.ristretto.desktop image/jpeg image/png image/gif image/bmp image/tiff

if [ "$NO_UNINSTALL" = false ]; then
  display "tte rain" "Removing any unnecessary packages"
  sudo apt -y purge brasero firefox* thunderbird gnome-chess gnome-games goldendict-ng hexchat hoichess pidgin remmina transmission* x11vnc
  sudo apt -y autoremove
else
  display "tte rain" "Skipping package removal (--no-uninstall mode)"
fi

display "tte rain" "Installing any available OS updates"
sudo apt -y dist-upgrade

display "tte rain" "Adding keyboard shortcuts"
echo "Press Super+PageUp to maximize a window"
gsettings set org.cinnamon.desktop.keybindings.wm toggle-maximized "['<Super>Page_Up']"
echo "Press Super+PageDown to minimize a window"
gsettings set org.cinnamon.desktop.keybindings.wm minimize "['<Super>Page_Down']"
echo "Press Super+W to close a window"
gsettings set org.cinnamon.desktop.keybindings.wm close "['<Alt>F4', '<Super>w']"
echo "Press Super+1 to switch to workspace 1"
gsettings set org.cinnamon.desktop.keybindings.wm switch-to-workspace-1 "['<Super>1']"
echo "Press Super+2 to switch to workspace 2"
gsettings set org.cinnamon.desktop.keybindings.wm switch-to-workspace-2 "['<Super>2']"
echo "Press Super+3 to switch to workspace 3"
gsettings set org.cinnamon.desktop.keybindings.wm switch-to-workspace-3 "['<Super>3']"
echo "Press Super+4 to switch to workspace 4"
gsettings set org.cinnamon.desktop.keybindings.wm switch-to-workspace-4 "['<Super>4']"
# To add a new custom keybinding, update the following line and then add a group of custom-xyz lines below
gsettings set org.cinnamon.desktop.keybindings custom-list "['custom-0', 'custom-1', 'custom-2', 'custom-3', 'custom-4', 'custom-5', 'custom-6', 'custom-7', 'custom-8', 'custom-9', 'custom-10', 'custom-11']"
# custom-0
echo "Press Ctrl+Shift+K for KeePassXC password manager"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-0/ name "KeePassXC"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-0/ command "/usr/local/bin/$PROJECT_LOWER-keepass"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-0/ binding "['<Ctrl><Shift>K']"
# custom-1
echo "Press Super+B for browser"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-1/ name "Chromium"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-1/ command "/usr/bin/chromium"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-1/ binding "['<Super>B']"
# custom-2
echo "Press Super+Return for terminal (alacritty)"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-2/ name "Alacritty"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-2/ command "/usr/bin/alacritty"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-2/ binding "['<Super>Return']"
# custom-3
echo "Press Super+F for file manager (nemo)"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-3/ name "Nemo"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-3/ command "/usr/bin/nemo"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-3/ binding "['<Super>F']"
# custom-4
echo "Press Super+R to run the application launcher (rofi)"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-4/ name "Rofi"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-4/ command "/usr/bin/rofi -show drun"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-4/ binding "['<Super>R', '<Super>space']"
# custom-5
echo "Press Super+K to show all keyboard bindings"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-5/ name "Keyboard bindings"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-5/ command "/usr/bin/chromium https://github.com/dougburks/ohmydebn?tab=readme-ov-file#hotkeys"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-5/ binding "['<Super>K']"
# custom-6
echo "Press Super+T to launch btop"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-6/ name "btop"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-6/ command "/usr/bin/alacritty -e btop"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-6/ binding "['<Super>T']"
# custom-7
echo "Press Super+N to launch Neovim"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-7/ name "Neovim"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-7/ command "/usr/bin/alacritty -e nvim"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-7/ binding "['<Super>N']"
# custom-8
echo "Press Ctrl+Shift+O to show OhMyDebn logo"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-8/ name "OhMyDebn Logo"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-8/ command "/usr/local/bin/ohmydebn-logo-gui"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-8/ binding "['<Ctrl><Shift>O']"
# custom-9
echo "Press Ctrl+Shift+S to show screenfetch"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-9/ name "screenfetch"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-9/ command "/usr/local/bin/ohmydebn-screenfetch-gui"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-9/ binding "['<Ctrl><Shift>S']"
# custom-10
echo "Press Ctrl+Shift+A to show audio visualizer"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-10/ name "cava audio visualizer"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-10/ command "/usr/bin/alacritty -e cava"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-10/ binding "['<Ctrl><Shift>A']"
# custom-11
echo "Press Ctrl+Shift+Super+Space to change theme"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-11/ name "OhMyDebn theme selector"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-11/ command "/usr/local/bin/ohmydebn-theme-set-gui"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-11/ binding "['<Ctrl><Shift><Super>space']"

if pgrep -x cinnamon >/dev/null; then
  display "tte rain" "Restarting desktop to apply keybindings"
  sleep 1s
  /usr/bin/cinnamon --replace >/dev/null 2>&1 &
  sleep 1s
  echo "You can see all keybindings by pressing Super + K"
fi

if [ ! -f $STATE_FILE ]; then
  display "tte rain" "Installation complete!"
  echo
  screenfetch -N | tte slide --merge
  echo
  welcome
  # Create a state file signifying that installation is complete
  touch ~/.local/state/ohmydebn
else
  echo
  echo "Update complete!"
fi
