#!/bin/bash

display "cat" "Updating themes"
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
