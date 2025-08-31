#!/bin/bash

BAT_CACHE_METADATA=~/.cache/bat/metadata.yaml
if [ ! -f $BAT_CACHE_METADATA ]; then
  display "cat" "Building cache for bat"
  bat cache --build
fi
