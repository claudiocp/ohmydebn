#!/bin/bash

if [ -f $STATE_FILE ]; then
  echo
  echo "Update complete!"
else
  display "tte rain" "Installation complete!"
  echo
  screenfetch -N | tte slide --merge
  echo
  welcome
  # Create a state file signifying that installation is complete
  touch $STATE_FILE
fi
