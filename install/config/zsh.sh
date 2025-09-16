#!/bin/bash

if [ ! -f ~/.zshrc ]; then
  ~/.local/share/ohmymint/bin/ohmymint-headline "cat" "Configuring Zsh"
  cp ~/.local/share/ohmymint/config/.zshrc ~/
fi

for FILE in ~/.bashrc ~/.xsessionrc ~/.zshrc; do
  if ! grep ".local/share/ohmymint/bin" $FILE >/dev/null 2>&1; then
    ~/.local/share/ohmymint/bin/ohmymint-headline "cat" "Updating PATH in $FILE"
    cat <<'EOF' >>$FILE

# Update PATH to include OhMyMint binaries
if ! [[ "$PATH" =~ "$HOME/.local/share/ohmymint/bin:" ]]; then
  export PATH="$HOME/.local/share/ohmymint/bin:$PATH"
fi
EOF
  fi
done
