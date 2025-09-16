#!/bin/bash

# Some installs might have an incorrect symlink that needs to be removed
OLD_SYMLINK=~/.local/share/ohmymint/themes/ohmymint/ohmydebn
if [ -L $OLD_SYMLINK ]; then
  echo "Removing old symlink $OLD_SYMLINK"
  rm -f $OLD_SYMLINK
fi
