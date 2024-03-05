#!/bin/sh

set -e

module_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

install() {
  defaults write com.apple.bird optimize-storage -bool false                         # Keep iCloud files downloaded
}

install
