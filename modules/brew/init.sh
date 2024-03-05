#!/bin/sh

set -e

module_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Requires bash
# Requires curl
# Requires interaction
# Requires 'macos' os?
# Provides brew
install() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  brew bundle install --file "$module_dir/Brewfile"
}

install
