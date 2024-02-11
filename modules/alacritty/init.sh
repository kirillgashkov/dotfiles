#!/bin/sh

set -e

module_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Config requires tokyonight.nvim (repository at ~/.local/share/nvim/lazy/tokyonight.nvim)
# Config requires font-jetbrains-mono-nerd-font (font named 'JetBrainsMono Nerd Font Mono')
# Config requries tmux (executable at /usr/local/bin/tmux)
# Config requires tmux (key bindings)
install() {
  brew install --cask alacritty
  test ! -e "$XDG_CONFIG_HOME/alacritty"
  ln -s "$module_dir/config" "$XDG_CONFIG_HOME/alacritty"
}

install
