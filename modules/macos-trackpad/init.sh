#!/bin/sh

set -e

module_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

install() {
  defaults write NSGlobalDomain com.apple.trackpad.scaling -int 1                    # Make tracking speed faster
  defaults write com.apple.AppleMultitouchTrackpad ActuationStrength -int 0          # Enable silent clicking
  defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 0        # Make trackpad click feel light (also set SecondClickThreshold)
  defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 0       # Make trackpad click feel light (also set FirstClickThreshold)
}

install
