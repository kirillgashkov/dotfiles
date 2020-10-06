# Dotfiles

Files that start with a dot.

## Installation

### 1. Install Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

### 2. Bundle Brewfile

```sh
git clone https://github.com/kirillgashkov/dotfiles.git ~/.dotfiles
brew bundle --file ~/.dotfiles/Brewfile
```

### 3. Setup Dotfiles

```sh
cd ~/.dotfiles
sh ./bootstrap.sh
zsh
```

### 4. Setup system

<details>
  <summary><i>Tweak dock's settings</i></summary>

  ```sh
  # Speed up the dock's hiding animation (delete this key to revert)
  defaults write com.apple.dock autohide-time-modifier -float 0.7
  # Speed up the dock's autohide delay (delete this key to revert)
  defaults write com.apple.dock autohide-delay -float 0.2
  # Apply changes
  killall Dock
  ```
</details>

<details>
  <summary><i>Show hidden files</i></summary>

  ```sh
  defaults write com.apple.finder AppleShowAllFiles TRUE
  killall Finder
  ```
</details>

### 5. Setup apps

<details>
  <summary><i>Finder</i></summary>

  - Visibility
    - Make `~/Library` visible
    - Make hidden files visible
  - Extensions
    - Make extensions visible
    - Suppress warnings when changing extensions
  - Miscellaneous
    - Make new tabs start at `~/`
    - Enable snap to grid
</details>

<details>
  <summary><i>Safari</i></summary>

  - Show `Develop` menu
</details>

<details>
  <summary><i>1Password</i></summary>

  - Turn helper off
</details>

<details>
  <summary><i>Alfred</i></summary>

  - Default results:
    - turn "Folders" on and everything else off
  - File Search:
    - turn off "open", "find", "tags"
  - Web Search:
    - turn everything off
  - Dictionary:
    - rename "define" to "def"
    - turn off "spell"
  - System:
    - turn confirmation on for "emptytrash", "restart", "shutdown", "quitall"
    - turn off "volup", "voldown", "mute"
    - turn on "ejectall"
  - Appearance:
    - select "Alfred macOS Dark"
    - check "hide hat" and "hide menu bar icon" in options
</details>

<details>
  <summary><i>Amphetamine</i></summary>

  - End session if charge is below 10%
  - Use "Caffeine" for menu bar image
</details>

<details>
  <summary><i>AppCleaner</i></summary>

  - Show protected apps
  - Protect default macOS apps
  - Do not protect running apps
</details>

<details>
  <summary><i>iTerm</i></summary>

  - Turn on custom folder preferences
</details>

<details>
  <summary><i>Spectacle</i></summary>

  - Unbind "Lower Left", "Lower Right", "Next Display", "Previous Display"
</details>

<details>
  <summary><i>Sublime Text</i></summary>

  - Copy settings to `User`
  - Install package control
  - Install packages:
    - LaTeXTools
    - Markdown Extended
    - MarkdownPreview
    - PlistBinary
  - Copy to `User` [Russian-English Bilingual](https://github.com/titoBouzout/Dictionaries) dictionary (`.aff` and `.dic`).
</details>

<details>
  <summary><i>Transmission</i></summary>

  - Turn off sleep prevent
  - Turn on deletion of original torrent
  - Turn on check remove downloading
  - Turn on check quit downloading
</details>

<details>
  <summary><i>VLC</i></summary>

  - Copy `vlcrc` to `~/Library/Preferences/org.videolan.vlc/vlcrc`
</details>

<details>
  <summary><i>Xcode</i></summary>

  - Accounts:
    - add developer account
  - Text Editing:
    - add page guide at 80 characters
  - Source Control:
    - disabled source control
</details>

### 6. Generate SSH key

> [Generating a new SSH key](https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

```sh
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

## License

Distributed under the MIT License. See the [LICENSE.md](LICENSE.md) for details.

## Acknowledgments

- [ptb's dotfiles](https://github.com/ptb/mac-setup)
- [kevinSuttle's dotfiles](https://github.com/kevinSuttle/dotfiles)
- [mathiasbynens's dotfiles](https://github.com/mathiasbynens/dotfiles)
- [caarlos0's dotfiles](https://github.com/caarlos0/dotfiles)
