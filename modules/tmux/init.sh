#!/bin/sh

set -e

module_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Requires brew
# Requires 'XDG_CONFIG_HOME' variable
# Requires 'XDG_CONFIG_HOME' directory existence
# Requires alacritty (because of 'set-option -sa terminal-features ",alacritty:RGB"')
# Provides tmux
install() {
  brew install tmux
  test ! -e "$XDG_CONFIG_HOME/tmux"
  ln -s "$module_dir/config" "$XDG_CONFIG_HOME/tmux"
}

install
