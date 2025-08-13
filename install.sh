#!/bin/bash

clear
echo "OhMyDebn"

if ! dpkg -s "git" >/dev/null 2>&1; then
  echo "Please wait while installing git..."
  sudo apt -y install git
fi

# Use custom repo if specified, otherwise default to dougburks/ohmydebn
OHMYDEBN_REPO="${OHMYDEBN_REPO:-dougburks/ohmydebn}"

echo -e "\nCloning OhMyDebn from: https://github.com/${OHMYDEBN_REPO}.git"
rm -rf ~/.local/share/ohmydebn/
git clone "https://github.com/${OHMYDEBN_REPO}.git" ~/.local/share/ohmydebn >/dev/null

# Use custom branch if instructed
if [[ -n "$OHMYDEBN_REF" ]]; then
  echo -e "\eUsing branch: $OHMYDEBN_REF"
  cd ~/.local/share/ohmydebn
  git fetch origin "${OHMYDEBN_REF}" && git checkout "${OHMYDEBN_REF}"
  cd -
fi

echo -e "\nInstallation starting..."
source ~/.local/share/ohmydebn/ohmydebn.sh
