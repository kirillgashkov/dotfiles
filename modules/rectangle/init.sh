#!/bin/sh

set -e

module_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

install() {
  brew install --cask rectangle
  defaults write com.knollsoft.Rectangle alternateDefaultShortcuts -int 1  # Set shortcuts to Rectangle defaults
  defaults write com.knollsoft.Rectangle launchOnLogin -bool false  # Don't launch Rectangle on login
  defaults write com.knollsoft.Rectangle hideMenubarIcon -bool true  # Hide menu bar icon
  defaults write com.knollsoft.Rectangle subsequentExecutionMode -int 2  # Do nothing
  defaults write com.knollsoft.Rectangle windowSnapping -int 2  # Turn off window snapping
}

install
