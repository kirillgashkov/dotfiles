#!/bin/sh

set -e

module_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Config requires alacritty
install() {
  defaults write org.hammerspoon.Hammerspoon MJConfigFile -string "$XDG_CONFIG_HOME/hammerspoon/init.lua"  # Follow XDG Base Directory (https://github.com/Hammerspoon/hammerspoon/issues/2175)
  defaults write org.hammerspoon.Hammerspoon MJShowDockIconKey -bool false  # Hide the Dock icon
  defaults write org.hammerspoon.Hammerspoon MJShowMenuIconKey -bool false  # Hide the menu bar icon
  test ! -e "$XDG_CONFIG_HOME/hammerspoon"
  ln -s "$module_dir/config" "$XDG_CONFIG_HOME/hammerspoon"
}

install
