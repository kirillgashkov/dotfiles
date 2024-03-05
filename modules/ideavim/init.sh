#!/bin/sh

set -e

module_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# It's not really installable as it is an IDE plugin
# Maybe it shouldn't even be a separate module
install() {
  test ! -e "$XDG_CONFIG_HOME/ideavim"
  ln -s "$module_dir/config" "$XDG_CONFIG_HOME/ideavim"
}

install
