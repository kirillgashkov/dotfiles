#!/bin/sh

# Requires bash
# Requires curl
# Requires interaction
# Requires 'macos' os?
# Provides brew
install() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

install
