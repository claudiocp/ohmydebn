#!/bin/bash

~/.local/share/ohmydebn/bin/ohmydebn-headline "cat" "Updating themes"

# Update omarchy repo
if [ ! -d ~/.local/share/omarchy ]; then
  cd ~/.local/share/
  git clone https://github.com/basecamp/omarchy.git
else
  cd ~/.local/share/omarchy
  git pull
fi
cd - >/dev/null

# Create symlinks for all themes
mkdir -p ~/.config/ohmydebn/themes
for f in ~/.local/share/ohmydebn/themes/*; do
  THEME=$(basename $f)
  if [ ! -L ~/.config/ohmydebn/themes/$THEME ]; then
    ln -nfs "$f" ~/.config/ohmydebn/themes/
  fi
done
for f in ~/.local/share/omarchy/themes/*; do
  THEME=$(basename $f)
  if [ ! -L ~/.config/omarchy/themes/$THEME ]; then
    ln -nfs "$f" ~/.config/ohmydebn/themes/
  fi
done

# Download theme support
THEME_STATE=~/.local/state/ohmydebn-config/ohmydebn-themes-20250909
if [ ! -f $THEME_STATE ]; then
  cd
  echo "Downloading themes..."
  wget https://github.com/dougburks/ohmydebn/releases/download/20250909/ohmydebn-themes.tar.gz
  echo -n "Installing themes..."
  tar zxf ohmydebn-themes.tar.gz
  echo "done"
  rm -f ohmydebn-themes.tar.gz
  touch $THEME_STATE
fi

# Make sure default theme is set
if [ ! -f ~/.local/state/ohmydebn ]; then
  ~/.local/share/ohmydebn/bin/ohmydebn-headline "cat" "Setting default theme"
  mkdir -p ~/.config/ohmydebn/current
  ~/.local/share/ohmydebn/bin/ohmydebn-theme-set Ohmydebn
fi
