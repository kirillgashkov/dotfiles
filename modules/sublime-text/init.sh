#!/bin/sh

set -e

module_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Config requires font-jetbrains-mono
install() {
  brew install --cask sublime-text
  test ! -e "$HOME/Library/Application Support/Sublime Text"
  ln -s "$XDG_CONFIG_HOME/sublime-text" "$HOME/Library/Application Support/Sublime Text"  # https://www.sublimetext.com/docs/revert.html
  test ! -e "$XDG_CONFIG_HOME/sublime-text"
  ln -s "$module_dir/config" "$XDG_CONFIG_HOME/sublime-text"
}

install

