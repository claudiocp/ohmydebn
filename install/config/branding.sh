#!/bin/bash

# Allow the user to change the branding for screenfetch and screensaver
mkdir -p ~/.config/ohmydebn/branding
#cp ~/.local/share/ohmydebn/icon.txt ~/.config/ohmydebn/branding/about.txt
SCREENSAVER=~/.config/ohmydebn/branding/screensaver.txt
if [ ! -f $SCREENSAVER ]; then
  toilet -f mono12 OhMyDebn >~/.config/ohmydebn/branding/screensaver.txt
fi
