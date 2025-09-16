#!/bin/bash

~/.local/share/ohmymint/bin/ohmymint-headline "cat" "Updating themes"

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
mkdir -p ~/.config/ohmymint/themes
for f in ~/.local/share/ohmymint/themes/*; do
  THEME=$(basename $f)
  if [ ! -L ~/.config/ohmymint/themes/$THEME ]; then
    ln -nfs "$f" ~/.config/ohmymint/themes/
  fi
done
for f in ~/.local/share/omarchy/themes/*; do
  THEME=$(basename $f)
  if [ ! -L ~/.config/omarchy/themes/$THEME ]; then
    ln -nfs "$f" ~/.config/ohmymint/themes/
  fi
done

# Download theme support
THEME_STATE=~/.local/state/ohmymint-config/ohmymint-themes-20250911
if [ ! -f $THEME_STATE ]; then
  cd
  echo "Downloading themes..."
  wget https://github.com/dougburks/ohmymint-themes/releases/download/20250911/ohmymint-themes.tar.gz
  echo -n "Installing themes..."
  tar zxf ohmymint-themes.tar.gz
  echo "done"
  rm -f ohmymint-themes.tar.gz
  touch $THEME_STATE
fi

# Make sure default theme is set
if [ ! -f ~/.local/state/ohmymint ]; then
  ~/.local/share/ohmymint/bin/ohmymint-headline "cat" "Setting default theme"
  mkdir -p ~/.config/ohmymint/current
  ~/.local/share/ohmymint/bin/ohmymint-theme-set Ohmydebn
fi
