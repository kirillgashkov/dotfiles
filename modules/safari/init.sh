#!/bin/sh

set -e

module_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

install() {
  defaults write com.apple.Safari IncludeDevelopMenu -bool true                      # Show the Develop menu in Safari
}

install
