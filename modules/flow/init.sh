#!/bin/sh

set -e

module_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

install() {
  defaults write design.yugen.Flow showWelcomeWindow -bool false  # Don't show welcome window
}

install
