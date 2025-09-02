#!/bin/bash

if [ ! -f ~/.local/state/ohmydebn ]; then
  ~/.local/share/ohmydebn/bin/ohmydebn-headline "cat" "WARNING!

This script:
- is intended for a clean new installation.
$(if [ "$NO_UNINSTALL" = false ]; then echo "- will remove apps like FireFox, Thunderbird, and others."; else echo "- will NOT remove any existing packages (--no-uninstall mode)."; fi)
- may make changes to your APT configuration.

This script is totally unsupported. 
If it breaks your system, you get to keep both pieces!

Press Enter to continue or Ctrl-c to cancel."
  read input
fi
