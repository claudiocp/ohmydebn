#!/bin/bash

OHMYZSH_DIR=~/.oh-my-zsh
if [ ! -d $OHMYZSH_DIR ]; then
  ~/.local/share/ohmymint/bin/ohmymint-headline "cat" "Installing Oh My Zsh framework for Zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  mv ~/.zshrc ~/.zshrc.oh-my-zsh
fi
