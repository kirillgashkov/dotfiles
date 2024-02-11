#!/bin/sh

set -e

module_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Requires brew
# Requires 'XDG_CONFIG_HOME' variable
# Requires 'XDG_CONFIG_HOME' directory existence
# Requires alacritty (because of 'set-option -sa terminal-features ",alacritty:RGB"')
# Requires 'tmux-256-color' (because of 'set-option -g default-terminal "tmux-256color"')
# Requires fzf at /usr/local/bin/fzf (config)
# Requires tmux at /usr/local/bin/tmux (config)
# Requires xargs at /usr/bin/xargs (config)
# Requires echo (config)
# Requires (maybe) sh (config, because we use tmux commands that invoke shell)
# Provides tmux
install() {
  brew install tmux
  test ! -e "$XDG_CONFIG_HOME/tmux"
  ln -s "$module_dir/config" "$XDG_CONFIG_HOME/tmux"
}

install
