#!/bin/bash

ZSH_CONFIG=~/.zshrc
if [ ! -f $ZSH_CONFIG ]; then
  echo "Configuring Zsh"
  cp ~/.local/share/ohmydebn/config/.zshrc ~/
fi

for FILE in ~/.bashrc ~/.zshrc; do
  if ! grep ".local/share/ohmydebn/bin" $FILE >/dev/null 2>&1; then
    echo "Updating PATH in $FILE"
    echo "export PATH=$HOME/.local/share/ohmydebn/bin:$PATH" >>$FILE
  fi
done
