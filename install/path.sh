#!/bin/bash

for FILE in ~/.bashrc ~/.zshrc
if ! grep ".local/share/ohmydebn/bin" $FILE > /dev/null 2>&1; then
  echo "export PATH=$HOME/.local/share/ohmydebn/bin:$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH" >> $FILE
fi
