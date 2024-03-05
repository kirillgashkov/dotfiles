#!/bin/sh

set -e

module_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# (Config requires me (my name and email))
# Config requires diff-so-fancy
# Config requires git (config directory at ~/.config/git)
# Config requires git-lfs
install() {
  test ! -e "$XDG_CONFIG_HOME/git"
  ln -s "$module_dir/config" "$XDG_CONFIG_HOME/git"
}

install
