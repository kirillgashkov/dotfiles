#!/bin/sh

set -e

module_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

install() {
  test ! -e "$HOME/.local/bin/license"
  ln -s "$module_dir/license" "$HOME/.local/bin/license"
  test ! -e "$XDG_CONFIG_HOME/license"
  ln -s "$module_dir/config" "$XDG_CONFIG_HOME/license"
}

install
