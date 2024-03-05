#!/bin/sh

set -e

module_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Config requires ... (literally everything)
install() {
  test ! -e "$HOME/.zshenv"
  ln -s "$module_dir/.zshenv" "$HOME/.zshenv"
  test ! -e "$XDG_CONFIG_HOME/zsh"
  ln -s "$module_dir/config" "$XDG_CONFIG_HOME/zsh"
  "$(brew --prefix)/opt/fzf/install" --xdg --key-bindings --completion --no-update-rc
}

install
