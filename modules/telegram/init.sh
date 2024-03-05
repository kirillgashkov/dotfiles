#!/bin/sh

set -e

module_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

install() {
  defaults write ru.keepcoder.Telegram kArchiveIsHidden -bool true  # Hide archived chats from All Chats
}

install
