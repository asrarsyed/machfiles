# Profile File! Runs on Login! Environment Variables are set here!
# Global Order: zshenv, zprofile, zshrc, zlogin, zlogout

# <- Homebrew (if present) ->
if (( ! $+commands[brew] )); then
  # Define potential brew paths
  local DEFAULT_BREW_PATHS=("/opt/homebrew/bin/brew" \
                             "/usr/local/bin/brew" \
                             "/home/linuxbrew/.linuxbrew/bin/brew" \
                             "$HOME/.linuxbrew/bin/brew")

  # Search for brew in the defined paths
  for bp in "${DEFAULT_BREW_PATHS[@]}"; do
    if [[ -x "$bp" ]]; then
      # Found brew, set its path
      export BREW_PATH="$bp"
      break
    fi
  done

  # If brew was found, source the shellenv
  if [[ ! -z "$BREW_PATH" ]]; then
    eval "$( "$BREW_PATH" shellenv )" 
  fi
fi

# If brew is now available, set HOMEBREW_PREFIX and add site-functions
if (( $+commands[brew] )); then
  # Set HOMEBREW_PREFIX if not already set
  if [[ -z "$HOMEBREW_PREFIX" ]]; then
    export HOMEBREW_PREFIX="$(brew --prefix)"
  fi

  # Add Homebrew site-functions to FPATH
  local HOMEBREW_SITE_FUNCTIONS="$HOMEBREW_PREFIX/share/zsh/site-functions"
  if [[ -d "$HOMEBREW_SITE_FUNCTIONS" ]]; then
    typeset -TUx FPATH fpath
    fpath=("$HOMEBREW_SITE_FUNCTIONS" $fpath)
  fi
fi

# https://superuser.com/questions/1610587/disable-zsh-session-folder-completely
export SHELL_SESSIONS_DISABLE=1