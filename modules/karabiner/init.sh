#!/bin/sh

set -e

module_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Config requires osascript
# Config requires spotify (via osascript)
install() {
  brew install --cask karabiner-elements
  test ! -e "$XDG_CONFIG_HOME/karabiner"
  ln -s "$module_dir/config" "$XDG_CONFIG_HOME/karabiner"
}

install
