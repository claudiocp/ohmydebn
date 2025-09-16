#!/bin/bash

if [ ! -f ~/.local/share/fonts/CaskaydiaMonoNerdFont-Regular.ttf ]; then
  ~/.local/share/ohmymint/bin/ohmymint-headline "cat" "Configuring Caskaydia Nerd Font"
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/CascadiaMono.zip
  unzip CascadiaMono.zip -d ~/.local/share/fonts
  rm -f CascadiaMono.zip
  fc-cache -fv
fi
