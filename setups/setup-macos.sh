#!/bin/sh

mixins="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)/mixins"
source "$mixins/assert.sh"
source "$mixins/exit.sh"
source "$mixins/require.sh"


assert_loaded_environment

require_macos


# Give password to sudo upfront and prevent sudo session timeout

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2> /dev/null &

# Prevent preferences below from being overridden by System Preferences

osascript -e 'tell application "System Preferences" to quit'

# Set language and region preferences

defaults write NSGlobalDomain AppleLocale -string "en_US"                          # Region: US
defaults write NSGlobalDomain AppleLanguages -array "en-US" "ru-RU"                # Preferred languages: English (US), Russian
defaults write NSGlobalDomain AppleICUForce12HourTime -bool true                   # 12-hour time
defaults write NSGlobalDomain AppleICUNumberSymbols -dict \
    0 -string "." \
    1 -string "," \
    10 -string "." \
    17 -string ","                                                                 # US number separators
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"          # Metric measurement units
defaults write NSGlobalDomain AppleMetricUnits -bool true                          # Metric measurement units
defaults write NSGlobalDomain AppleTemperatureUnit -string "Celsius"               # Temperature: Celsius

# Set software update preferences

defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true           # Automatically check for updates
defaults write com.apple.SoftwareUpdate AutomaticDownload -bool true               # Automatically download new updates
defaults write com.apple.commerce AutoUpdate -bool true                            # Automatically install app updates

# Set Finder preferences

sudo chflags nohidden "/Volumes"                                                                # Show the /Volumes folder
chflags nohidden "$HOME/Library" && xattr -d com.apple.FinderInfo "$HOME/Library" 2> /dev/null  # Show the ~/Library folder


defaults write NSGlobalDomain AppleShowAllFiles -bool true                         # Show hidden files (in open/save dialogs too)
defaults write NSGlobalDomain AppleShowAllExtensions -bool true                    # Show all filename extensions (in open/save dialogs too)
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true       # Don't create .DS_Store files on network stores
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true           # Don't create .DS_Store files on USB stores

# Set Safari preferences

defaults write com.apple.Safari IncludeDevelopMenu -bool true                      # Show the Develop menu in Safari

# Set Photos preferences

defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true       # Don't automatically open Photos when devices are plugged in

# Make Sublime Text 4 the default app for code files

echo "$(tput bold)Making Sublime Text 4 the default app for code files$(tput sgr0)"
for domain in com.apple.applescript.script com.apple.applescript.text com.apple.property-list com.microsoft.word.wordml com.netscape.javascript-source com.sun.java-source .md public.ada-source public.assembly-source public.bash-script public.c-header public.c-plus-plus-header public.c-plus-plus-inline-header public.c-plus-plus-source public.c-plus-plus-source.preprocessed public.c-source public.c-source.preprocessed public.comma-separated-values-text public.csh-script public.css public.data public.dylan-source public.fortran-77-source public.fortran-90-source public.fortran-95-source public.fortran-source public.html public.json public.ksh-script public.lex-source public.make-source public.mig-source public.module-map public.nasm-assembly-source public.objective-c-plus-plus-source public.objective-c-plus-plus-source.preprocessed public.objective-c-source public.objective-c-source.preprocessed public.opencl-source public.pascal-source public.perl-script public.php-script public.plain-text public.precompiled-c-header public.precompiled-c-plus-plus-header public.protobuf-source public.python-script public.ruby-script public.script public.shell-script public.source-code public.source-code.preprocessed public.swift-source public.tab-separated-values-text public.tcsh-script public.unix-executable public.xhtml public.xml public.yacc-source public.yaml public.zsh-script; do
    duti -s com.sublimetext.4 "$domain" all
done

# Kill affected programs

for program in \
    "Activity Monitor" \
    "Address Book" \
    "Calendar" \
    "cfprefsd" \
    "Contacts" \
    "Finder" \
    "Mail" \
    "Messages" \
    "Photos" \
    "Safari" \
    "SystemUIServer" \
    "iCal"; do
    killall "$program" &> /dev/null
done


exit_with_success
