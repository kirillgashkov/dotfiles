#!/bin/sh

set -e

module_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Requires 'tokyonight.nvim' (because of the color scheme import)
install() {
  brew install --cask alacritty
  test ! -e "$XDG_CONFIG_HOME/alacritty"
  ln -s "$module_dir/config" "$XDG_CONFIG_HOME/alacritty"
}

install
