#!/bin/bash

# Parse command line arguments
NO_UNINSTALL=false
for arg in "$@"; do
  case $arg in
  --no-uninstall)
    NO_UNINSTALL=true
    shift
    ;;
  *)
    # Unknown option
    ;;
  esac
done
