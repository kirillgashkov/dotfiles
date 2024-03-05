#!/bin/sh

set -e

module_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

install() {
  defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false                 # Disable press-and-hold for keys in favor of key repeat
  defaults write NSGlobalDomain InitialKeyRepeat -int 15                             # Make delay until key repeat shorter
  defaults write NSGlobalDomain KeyRepeat -int 2                                     # Make key repeat faster
  defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false         # Disable automatic capitalization
  defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false       # Disable smart dashes
  defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false     # Disable automatic period substitution
  defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false      # Disable smart quotes
  defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false     # Disable auto-correct
  defaults write com.apple.HIToolbox AppleDictationAutoEnable -bool false            # Disable "Enable dictation" prompt when Fn key is pressed multiple times

  /usr/libexec/PlistBuddy \
    -c "Delete :AppleSymbolicHotKeys:60" \
    -c "Add :AppleSymbolicHotKeys:60:enabled bool true" \
    -c "Add :AppleSymbolicHotKeys:60:value dict" \
    -c "Add :AppleSymbolicHotKeys:60:value:parameters array" \
    -c "Add :AppleSymbolicHotKeys:60:value:parameters: integer 65535" \
    -c "Add :AppleSymbolicHotKeys:60:value:parameters: integer 80" \
    -c "Add :AppleSymbolicHotKeys:60:value:parameters: integer 8388608" \
    -c "Add :AppleSymbolicHotKeys:60:value:type string standard" \
    "$HOME/Library/Preferences/com.apple.symbolichotkeys.plist"                    # Map "Select the previous input source" shortcut to F19 (which is managed by Karabiner)
  /usr/libexec/PlistBuddy \
    -c "Set :AppleSymbolicHotKeys:61:enabled bool false" \
    "$HOME/Library/Preferences/com.apple.symbolichotkeys.plist"                    # Disable "Select the next source in Input menu" shortcut
  /usr/libexec/PlistBuddy \
    -c "Set :AppleSymbolicHotKeys:64:enabled bool false" \
    "$HOME/Library/Preferences/com.apple.symbolichotkeys.plist"                    # Disable "Show Spotlight search" shortcut (in favor of Alfred)
  /usr/libexec/PlistBuddy \
    -c "Set :AppleSymbolicHotKeys:65:enabled bool false" \
    "$HOME/Library/Preferences/com.apple.symbolichotkeys.plist"                    # Disable "Show Finder search window" shortcut
}

install
