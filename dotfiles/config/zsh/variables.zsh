# Global

export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export PATH="$HOME/.local/bin:$PATH"

# Zsh

export FPATH="$XDG_CONFIG_HOME/zsh/completions:$FPATH"
PROMPT_EOL_MARK=""
PS2="%B…%b "
HISTFILE="$XDG_DATA_HOME/zsh/.zhistory"
HISTSIZE=10000
SAVEHIST=10000
KEYTIMEOUT=1

ZCOMPDUMP="$XDG_CACHE_HOME/zsh/.zcompdump"  # User-defined
PROMPT_STYLE="regular"                      # User-defined

# Pyenv

export PATH="$PYENV_ROOT/shims:$PATH"  # FIXME: 'PYENV_ROOT'

# Go

export PATH="$GOPATH/bin:$PATH"

# Tealdeer

export TEALDEER_CONFIG_DIR="$XDG_CONFIG_HOME/tealdeer"

# My utils

export REPOSITORIES="$HOME/Repositories"
export WORKSPACES="$HOME/Workspaces"
export NOTES="$HOME/Cloud/notes"
export DOTFILES_ENVIRONMENT_LOADED=1

# Homebrew

# libpq. Not symlinked by default. Provides `pg_dump`, `psql`, etc.
export PATH="/usr/local/opt/libpq/bin:$PATH"
export MANPATH="/usr/local/opt/libpq/share/man:$MANPATH"

# mysql-client. Not symlinked by default. Provides `mysql`, etc.
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
export MANPATH="/usr/local/opt/mysql-client/share/man:$MANPATH"

# openjdk. Not symlinked by default. Provides `java`, etc.
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="/usr/local/opt/openjdk/share/man:$PATH"
