#!/bin/sh

set -e

module_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

install() {
  defaults write com.apple.dock mru-spaces -bool false                               # Don't automatically rearrange Spaces
  defaults write com.apple.dock wvous-br-corner -int 1                               # Turn off quick note feature
}

install
