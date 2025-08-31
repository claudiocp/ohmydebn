#!/bin/bash

ZSH_CONFIG=~/.zshrc
if [ ! -f $ZSH_CONFIG ]; then
  display "cat" "Configuring Zsh"
  cp ~/.local/share/$PROJECT_LOWER/config/.zshrc ~/
fi
