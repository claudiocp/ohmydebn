#!/bin/bash

if [ ! -f ~/.zshrc ]; then
  ~/.local/share/ohmydebn/bin/ohmydebn-headline "cat" "Configuring Zsh"
  cp ~/.local/share/ohmydebn/config/.zshrc ~/
fi

for FILE in ~/.bashrc ~/.xsessionrc ~/.zshrc; do
  if ! grep ".local/share/ohmydebn/bin" $FILE >/dev/null 2>&1; then
    ~/.local/share/ohmydebn/bin/ohmydebn-headline "cat" "Updating PATH in $FILE"
    cat <<'EOF' >>$FILE

# Update PATH to include OhMyDebn binaries
if ! [[ "$PATH" =~ "$HOME/.local/share/ohmydebn/bin:" ]]; then
  export PATH="$HOME/.local/share/ohmydebn/bin:$PATH"
fi
EOF
  fi
done
