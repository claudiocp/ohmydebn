#!/bin/bash

for FILE in ~/.bashrc ~/.zshrc; do
  if ! grep ".local/share/ohmydebn/bin" $FILE >/dev/null 2>&1; then
    echo "Updating PATH in $FILE"
    echo "export PATH=$HOME/.local/share/ohmydebn/bin:$PATH" >>$FILE
  fi
done
