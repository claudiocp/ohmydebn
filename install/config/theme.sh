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
