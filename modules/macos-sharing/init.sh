#!/bin/sh

set -e

module_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

install() {
  sudo scutil --set ComputerName "Kirill's MacBook"                       # Set computer name
  sudo scutil --set LocalHostName "kirills-macbook"                       # Set local hostname
}

install
