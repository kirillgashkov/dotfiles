#!/bin/sh

set -e

module_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

install() {
  mas install 937984704  # Amphetamine
  defaults write com.if.Amphetamine "Show Welcome Window" -bool false  # Don't show welcome window
  defaults write com.if.Amphetamine "Enable Session State Sound" -bool false  # Don't play sound when any session starts or ends
  defaults write com.if.Amphetamine "Icon Style" -int 5  # Set menu bar icon to a coffee cup
}

install
