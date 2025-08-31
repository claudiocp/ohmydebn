#!/bin/bash

ZSH_CONFIG=~/.zshrc
if [ ! -f $ZSH_CONFIG ]; then
  display "cat" "Configuring Zsh"
  cp ~/.local/share/ohmydebn/config/.zshrc ~/
fi
