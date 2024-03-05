#!/bin/sh

set -e

module_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

install() {
  defaults write com.apple.dock autohide -bool true                                  # Automatically hide and show the Dock
  defaults write com.apple.dock autohide-delay -float 0.2                            # Speed up the Dock's auto-hiding
  defaults write com.apple.dock autohide-time-modifier -float 0.7                    # Speed up the Dock's hiding/showing animation
  defaults write com.apple.dock minimize-to-application -bool true                   # Minimize windows into application icon in Dock
  defaults write com.apple.dock persistent-apps -array                               # Remove all (default) icons from Dock
  defaults write com.apple.dock show-process-indicators -bool true                   # Show indicators for open applications in Dock
  defaults write com.apple.dock show-recents -bool false                             # Don't show recent applications in Dock
}

install
