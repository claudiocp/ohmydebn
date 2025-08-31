#!/bin/bash

function logo {
  toilet -f mono12 "OhMyDebn" | tte rain
}

function welcome {
  toilet -f mono12 "Welcome" | tte rain
  toilet -f mono12 "   to" | tte rain
  logo
}

function display {
  echo
  if [ ! -f ~/.local/state/ohmydebn ]; then
    # For first installation, use text effects
    PROCESSOR=$1
  else
    # For updates, don't use text effects
    PROCESSOR=cat
  fi
  cat <<EOF | $PROCESSOR
###############################################################################
$2
###############################################################################
EOF
  echo
}
