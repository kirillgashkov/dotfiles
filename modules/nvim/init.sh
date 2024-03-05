#!/bin/sh

set -e

module_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Config requires git
# Config requires ... (plugins but they are managed by Neovim itself)
# (Config provides tokyonight.nvim)
install() {
  brew install --formula neovim
  test ! -e "$XDG_CONFIG_HOME/nvim"
  ln -s "$module_dir/config" "$XDG_CONFIG_HOME/nvim"
}

install
