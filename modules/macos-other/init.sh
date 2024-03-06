#!/bin/sh

set -e

module_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

install() {
  defaults write NSGlobalDomain AppleShowAllFiles -bool true                         # Show hidden files (in open/save dialogs too)
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true                    # Show all filename extensions (in open/save dialogs too)
}

install
