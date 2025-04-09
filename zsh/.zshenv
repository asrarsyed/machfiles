# Profile File! Runs on Login! Environment Variables are set here!
# Global Order: zshenv, zprofile, zshrc, zlogin, zlogout

# <- XDG Base Directory Specification ->
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_DATA_DIRS="${XDG_DATA_DIRS:-$XDG_DATA_HOME:/usr/share:/usr/local/share}"

# <- ZSH Config Directory ->
export ZDOTDIR="${ZDOTDIR:-$HOME/.config/zsh}"

# <- Path Management ->
typeset -gU path cdpath fpath manpath
path=("$path[@]")

# Adds `~/usr/local/bin`
[ -d "/usr/local/bin" ] && export PATH="/usr/local/bin:$PATH"

# Adds `~/.local/bin` and all subdirs to $PATH (macOS compatible version)
[ -d "$HOME/.local/bin" ] && export PATH="$PATH:$(find ~/.local/bin -type d -print | tr '\n' ':' | sed 's/:$//')"

# Basic language settings
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'

# Skip global compinit for performance
skip_global_compinit=1