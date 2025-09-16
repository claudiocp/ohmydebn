#!/bin/bash

if [ ! -f ~/.local/state/ohmymint ]; then
  ~/.local/share/ohmymint/bin/ohmymint-headline "cat" "WARNING!

- OhMyMint is intended for a clean new installation.
- OhMyMint will remove apps like FireFox, Thunderbird, and others (unless you use the --no-uninstall option).
- OhMyMint may make changes to your APT configuration.
- OhMyMint is totally unsupported. If it breaks your system, you get to keep both pieces!

Press Enter to continue or Ctrl-c to cancel."
  read input
fi
