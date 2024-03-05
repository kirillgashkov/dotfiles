#!/bin/sh

set -e

module_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Config requires tealdeer pages directory at /Users/kirill/.config/tealdeer/pages
install() {
  test ! -e "$XDG_CONFIG_HOME/tldr"
  ln -s "$module_dir/config" "$XDG_CONFIG_HOME/tldr"
  tldr --update  # Implementation specific, works for 'tealdeer'
}

install
