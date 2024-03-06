#!/bin/sh

set -e

module_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

install() {
  defaults write NSGlobalDomain AppleLocale -string "en_US"                          # Region: US
  defaults write NSGlobalDomain AppleLanguages -array "en-US" "ru-RU"                # Preferred languages: English (US), Russian
  defaults write NSGlobalDomain AppleICUForce12HourTime -bool true                   # 12-hour time
  defaults write NSGlobalDomain AppleICUNumberSymbols -dict \
    0 -string "." \
    1 -string "," \
    10 -string "." \
    17 -string ","                                                                   # US number separators
  defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"          # Metric measurement units
  defaults write NSGlobalDomain AppleMetricUnits -bool true                          # Metric measurement units
  defaults write NSGlobalDomain AppleTemperatureUnit -string "Celsius"               # Temperature: Celsius
}

install
