#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

PROJECT="OhMyDebn"
PROJECTLOWER=$(echo "$PROJECT" | tr '[:upper:]' '[:lower:]')

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

clear
display "cat" "Welcome to $PROJECT!

$PROJECT is a debonair Debian + Cinnamon setup inspired by Omarchy.

Debonair strides bold,
Elegance in every step,
Stars bow to its charm.
 -- AI, probably

WARNING!

This script:
- is intended for a clean new installation.
- will remove apps like FireFox, Thunderbird, and others.
- may make changes to your APT configuration.

This script is totally unsupported. 
If it breaks your system, you get to keep both pieces!

Press Enter to continue or Ctrl-c to cancel."
read input

clear

SOURCESLIST=/etc/apt/sources.list
if ! grep -q "debian.org" $SOURCESLIST; then
  display "cat" "$SOURCESLIST does not have any debian.org references."
  if [ -f $SOURCESLIST ]; then
	  echo "Renaming $SOURCESLIST to $SOURCESLIST.orig"
	  sudo mv $SOURCESLIST $SOURCESLIST.orig
  fi
  DEBIANSOURCES=/etc/apt/sources.list.d/debian.sources
  if [ ! -f $DEBIANSOURCES ]; then
	  echo "$DEBIANSOURCES does not exist."
	  echo "Creating $DEBIANSOURCES and adding the following:"
	  cat << EOF | sudo tee -a $DEBIANSOURCES
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

display "cat" "First, this terminal needs more color!"
sudo apt update
sudo apt -y install curl libglib2.0-bin python3-terminaltexteffects toilet
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ foreground-color "'#D3D7CF'"
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ background-color "'#2E3436'"
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ use-theme-colors false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ palette "['#2e3436', '#cc0000', '#4e9a06', '#c4a000', '#3465a4', '#75507b', '#06989a', '#d3d7cf', '#555753', '#ef2929', '#8ae234', '#fce94f', '#729fcf', '#ad7fa8', '#34e2e2', '#eeeeec']"

logo
echo
if [ $(dpkg -l | grep "^ii  mint-" | wc -l) -eq 0 ]; then
  display "tte waves" "Installing themes"
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
  sudo apt update && sudo apt -y install mint-themes
  echo
  sudo rm -f $MINTLIST
  sudo apt update
  echo
  sudo apt -y purge linuxmint-keyring
fi

if [ ! -f /usr/share/wallpapers/$PROJECTLOWER.jpg ]; then
  display "tte rain" "Downloading catppuccin mountain landscape wallpaper"
  sudo curl https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/main/landscapes/salty_mountains.png -o /usr/share/wallpapers/$PROJECTLOWER.png

  display "tte rain" "Changing wallpaper"
  gsettings set org.cinnamon.desktop.background picture-uri "'file:///usr/share/wallpapers/$PROJECTLOWER.png'"
fi

display "tte rain" "Setting Cinnamon theme"
gsettings set org.cinnamon.theme name "'Mint-Y-Dark-Aqua'"

display "tte rain" "Setting cursor theme"
sudo apt -y install bibata-cursor-theme
gsettings set org.cinnamon.desktop.interface cursor-theme "'Bibata-Modern-Classic'"

display "tte rain" "Setting GTK theme"
gsettings set org.cinnamon.desktop.interface gtk-theme "'Mint-Y-Dark-Aqua'"

display "tte rain" "Setting icon theme"
gsettings set org.cinnamon.desktop.interface icon-theme "'Mint-Y-Sand'"

display "tte rain" "Setting alttab switcher style to coverflow"
gsettings set org.cinnamon alttab-switcher-style "'coverflow'"

display "tte rain" "Configuring alttab switcher for all workspaces"
gsettings set org.cinnamon alttab-switcher-show-all-workspaces true

display "tte rain" "Changing grouped window list to window list"
gsettings set org.cinnamon enabled-applets "$(gsettings get org.cinnamon enabled-applets | sed "s/panel1:left:[0-9]*:grouped-window-list@cinnamon.org:[0-9]*/panel1:left:1:window-list@cinnamon.org:12/")"

display "tte rain" "Enabling workspace switcher"
gsettings set org.cinnamon enabled-applets "$(gsettings get org.cinnamon enabled-applets | sed 's/]$/, "panel1:right:0:workspace-switcher@cinnamon.org:10"]/')"

display "tte rain" "Installing some new apps"
sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt -y install alacritty binutils btop chromium curl fzf git gimp golang gvfs-backends htop iperf3 keepassxc neovim openvpn pdftk-java python-is-python3 ripgrep screenfetch vim wget xdotool

display "tte rain" "Setting alacritty as default terminal emulator"
gsettings set org.cinnamon.desktop.default-applications.terminal exec "'alacritty'"

display "tte rain" "Configuring alacritty with Caskyadia Nerd Font"
if [ ! -f ~/.local/share/fonts/CaskaydiaMonoNerdFont-Regular.ttf ]; then
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/CascadiaMono.zip
  unzip CascadiaMono.zip -d ~/.local/share/fonts
  rm -f CascadiaMono.zip
  fc-cache -fv
fi

display "tte rain" "Configuring alacritty terminal editor with catppuccin theme"
mkdir -p ~/.config/alacritty/
if [ ! -f ~/.config/alacritty/catpuccin-mocha.toml ]; then
  curl -LO --output-dir ~/.config/alacritty https://github.com/catppuccin/alacritty/raw/main/catppuccin-mocha.toml
fi
if [ ! -f ~/.config/alacritty/alacritty.toml ]; then
  cat <<EOF >>~/.config/alacritty/alacritty.toml
[env]
TERM = "xterm-256color"
[window]
opacity = 0.97  # Values from 0.0 (fully transparent) to 1.0 (opaque)
padding.x = 14
padding.y = 14
decorations = "Full"
[font]
normal = { family = "CaskaydiaMono Nerd Font", style = "Regular" }
bold = { family = "CaskaydiaMono Nerd Font", style = "Bold" }
italic = { family = "CaskaydiaMono Nerd Font", style = "Italic" }
[general]
import = [
  "~/.config/alacritty/catppuccin-mocha.toml"
]
EOF
fi

display "tte rain" "Configuring btop with catppuccin theme"
BTOPCONFIG=~/.config/btop
mkdir -p $BTOPCONFIG
cd $BTOPCONFIG
if [ ! -f themes.tar.gz ]; then
  curl -LO https://github.com/catppuccin/btop/releases/download/1.0.0/themes.tar.gz
  tar zxvf themes.tar.gz
  echo "color_theme = \"$BTOPCONFIG/themes/catppuccin_mocha.theme\"" >btop.conf
fi
cd - >/dev/null

display "tte rain" "Configuring neovim with lazyvim"
if [ ! -d ~/.config/nvim ]; then
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  rm -rf ~/.config/nvim/.git
fi

display "tte rain" "Configuring neovim with catppuccin theme"
NVIMPLUGINS=~/.config/nvim/lua/plugins
mkdir -p $NVIMPLUGINS
if [ ! -f $NVIMPLUGINS/core.lua ]; then
  cat <<EOF >>~/.config/nvim/lua/plugins/core.lua
return {
  { "LazyVim/LazyVim", opts = { colorscheme = "catppuccin" } }
}
EOF
fi

display "tte rain" "Configuring chromium"
mkdir -p ~/.config/chromium/"External Extensions"
cat <<EOF >>~/.config/chromium/"External Extensions/ddkjiahejlhfcafbddmgiahcphecmpfh.json"
{
  "external_update_url": "https://clients2.google.com/service/update2/crx"
}
EOF

display "tte rain" "Configuring KeePassXC"
KEEPASS="/usr/local/bin/$PROJECTLOWER-keepass"
if [ ! -f $KEEPASS ]; then
  cat <<EOF | sudo tee -a $KEEPASS
#!/bin/bash
if ! pgrep keepassxc; then
	/usr/bin/keepassxc &
else
	/usr/bin/xdotool search --name ".*- KeePassXC" windowactivate
fi
EOF
  sudo chmod +x $KEEPASS
fi
KEEPASSCONFIGDIR=~/.config/keepassxc
mkdir -p $KEEPASSCONFIGDIR
KEEPASSCONFIG=$KEEPASSCONFIGDIR/keepassxc.ini
if [ ! -f $KEEPASSCONFIG ]; then
  cat <<EOF >>$KEEPASSCONFIG
[General]
AutoTypeStartDelay=100
ConfigVersion=2
GlobalAutoTypeKey=80
GlobalAutoTypeModifiers=100663296

[GUI]
ApplicationTheme=dark
EOF
fi

display "tte rain" "Adding keyboard shortcuts"
echo "Super+PageUp to maximize a window"
gsettings set org.cinnamon.desktop.keybindings.wm maximize "['<Super>Page_Up']"
echo "Super+PageDown to minimize a window"
gsettings set org.cinnamon.desktop.keybindings.wm minimize "['<Super>Page_Down']"
# To add a new custom keybinding, update the following line and then add a group of 3 custom-xyz lines below
gsettings set org.cinnamon.desktop.keybindings custom-list "['custom-0', 'custom-1', 'custom-2', 'custom-3']"
echo "Ctrl+Shift+K for KeePassXC password manager"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-0/ name "KeePassXC"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-0/ command "/usr/local/bin/$PROJECTLOWER-keepass"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-0/ binding "['<Ctrl><Shift>K']"
echo "Super+B for browser"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-1/ name "Chromium"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-1/ command "/usr/bin/chromium"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-1/ binding "['<Super>B']"
echo "Super+Return for terminal (alacritty)"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-2/ name "Alacritty"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-2/ command "/usr/bin/alacritty"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-2/ binding "['<Super>Return']"
echo "Super+F for file manager (nemo)"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-3/ name "Nemo"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-3/ command "/usr/bin/nemo"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom-3/ binding "['<Super>F']"

display "tte rain" "Removing unnecessary packages"
sudo apt -y purge brasero firefox* thunderbird firefox* gnome-chess gnome-games goldendict-ng hexchat hoichess pidgin remmina thunderbird transmission* x11vnc
sudo apt -y autoremove

display "tte rain" "Installing all updates"
sudo apt -y dist-upgrade

display "tte rain" "Installation complete!"
echo
screenfetch -N | tte slide --merge
echo
welcome
