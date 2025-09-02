#!/bin/bash

NVIM_CONFIG_DIR=~/.config/nvim
if [ ! -d $NVIM_CONFIG_DIR ]; then
  ~/.local/share/ohmydebn/bin/ohmydebn-headline "cat" "Configuring neovim with lazyvim"
  git clone https://github.com/LazyVim/starter $NVIM_CONFIG_DIR
  rm -rf $NVIM_CONFIG_DIR/.git
fi

NVIM_PLUGINS=$NVIM_CONFIG_DIR/lua/plugins
mkdir -p $NVIM_PLUGINS
if grep -q "colorscheme = \"catppuccin\"" $NVIM_PLUGINS/core.lua >/dev/null 2>&1; then
  ~/.local/share/ohmydebn/bin/ohmydebn-headline "cat" "Disabling old static neovim theme config"
  mv $NVIM_PLUGINS/core.lua $NVIM_PLUGINS/core.lua.disabled
fi

NVIM_THEME=$NVIM_PLUGINS/theme.lua
if [ ! -L $NVIM_THEME ]; then
  ~/.local/share/ohmydebn/bin/ohmydebn-headline "cat" "Configuring neovim theme"
  ln -snf ~/.config/ohmydebn/current/theme/neovim.lua $NVIM_THEME
fi

~/.local/share/ohmydebn/bin/ohmydebn-headline "cat" "Updating neovim config"
cp -av ~/.local/share/ohmydebn/config/nvim ~/.config/

NVIM_OPTIONS=$NVIM_CONFIG_DIR/lua/config/options.lua
if ! grep -q "vim.opt.relativenumber = false" $NVIM_OPTIONS >/dev/null 2>&1; then
  echo "vim.opt.relativenumber = false" >>$NVIM_OPTIONS
fi
