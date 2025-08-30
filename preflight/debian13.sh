#!/bin/bash

display "cat" "This is a test"

if ! grep -q "13 (trixie)" /etc/os-release; then
  display "cat" "This script is designed for Debian 13 Cinnamon. Exiting!"
  exit 1
fi
