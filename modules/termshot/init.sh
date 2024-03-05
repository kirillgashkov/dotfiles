#!/bin/sh

set -e

module_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Config requires alacritty
# Config requires font-jetbrains-mono (via alacritty)
# Config requires tmux
# 'termshot' requires zsh
# 'termshot' requires alacritty
# 'termshot' requires hammerspoon (its CLI)
# 'termshot' requires tmux
# 'termshot' requires screencapture
# 'termshot' requires ... (other common CLI tools, mostly GNU versions when available)
# 'autotermshot' requires zsh
# 'autotermshot' requires termshot
# 'autotermshot' requires tmux
# 'autotermshot' requires vipe
# 'autotermshot' requires ... (other common CLI tools, mostly GNU versions when available)
install() {
  test ! -e "$HOME/.local/bin/termshot"
  ln -s "$module_dir/termshot" "$HOME/.local/bin/termshot"
  test ! -e "$HOME/.local/bin/autotermshot"
  ln -s "$module_dir/autotermshot" "$HOME/.local/bin/autotermshot"
  test ! -e "$XDG_CONFIG_HOME/termshot"
  ln -s "$module_dir/config" "$XDG_CONFIG_HOME/termshot"
}

install

