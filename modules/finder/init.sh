#!/bin/sh

set -e

module_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

install() {
  defaults write com.apple.finder NewWindowTarget -string "PfHm"                     # Show home for new Finder windows
  defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME/"        # Show home for new Finder windows
  defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true         # Show external disks on the desktop
  defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true             # Show removable media on the desktop
  defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false                # Don't show hard drives on the desktop
  defaults write com.apple.finder ShowMountedServersOnDesktop -bool false            # Don't show connected servers on the desktop
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false         # Don't show warning before changing an extension
  defaults write com.apple.finder _FXSortFoldersFirst -bool true                     # Keep folders on top when sorting by name
  defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"                # Search the current folder when performing a search
  defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"                # Use list view in all Finder windows

  /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" "$HOME/Library/Preferences/com.apple.finder.plist"   # Snap-to-grid for icons on the desktop
  /usr/libexec/PlistBuddy -c "Set :ICloudViewSettings:IconViewSettings:arrangeBy grid" "$HOME/Library/Preferences/com.apple.finder.plist"    # Snap-to-grid for icons in iCloud Drive
  /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" "$HOME/Library/Preferences/com.apple.finder.plist"  # Snap-to-grid for icons in other icon views
}

install
