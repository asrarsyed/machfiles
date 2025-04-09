# <- Environment Variables -> #

# PATH additions for specific tools
export PATH="/opt/homebrew/opt/trash/bin:$PATH" # Add brew CLI trash

# Terminal Settings
export TERM=xterm-256color
export COLORTERM='truecolor'

# Set EDITOR/VISUAL based on available editors
if (( $+commands[nvim] )); then
  export EDITOR=nvim
  export VISUAL=code
elif (( $+commands[code] )); then
  export EDITOR=vim
  export VISUAL=code
else
  export EDITOR=vim
  export VISUAL=vim
fi

# Homebrew Configuration
export HOMEBREW_VERBOSE=1                # Detailed debug output (slower)
export HOMEBREW_NO_ANALYTICS=1           # Privacy
export HOMEBREW_NO_ENV_HINTS=1           # Clean output
export HOMEBREW_NO_AUTO_UPDATE=          # Skip auto updates (faster but riskier)
export HOMEBREW_BUNDLE_NO_LOCK=1         # No lock files for brew bundle
export HOMEBREW_INSTALL_CLEANUP=1        # Auto cleanup
export HOMEBREW_FORCE_BREWED_CURL=1      # Consistent curl version
export HOMEBREW_BUNDLE_FILE=~/brewfile    # Default Brewfile path

# Man Configuration
export MANWIDTH='100'
export MANPAGER='nvim +Man!'

# Less Configuration
export PAGER=less
export LESS='-~ --tabs=4 --incsearch -i --LONG-PROMPT -c -d -J --jump-target=10 -S -R -s'
export LESSOPEN="|$XDG_CONFIG_HOME/less/lessfilter.sh %s"
export LESSHISTFILE="$XDG_CONFIG_HOME/less/history"

# Less Colors
if [[ ${PAGER} == 'less' ]]; then
    (( ! ${+LESS_TERMCAP_mh} )) && export LESS_TERMCAP_mh=$'\e[2m'             # Turn on dim mode
    (( ! ${+LESS_TERMCAP_mr} )) && export LESS_TERMCAP_mr=$'\e[7m'             # Turn on reverse mode
    (( ! ${+LESS_TERMCAP_me} )) && export LESS_TERMCAP_me=$'\e[0m'             # Turn off all attributes
    (( ! ${+LESS_TERMCAP_mb} )) && export LESS_TERMCAP_mb=$'\E[1;31m'          # Begins blinking
    (( ! ${+LESS_TERMCAP_se} )) && export LESS_TERMCAP_se=$'\e[27;0m'          # Exit standout mode
    (( ! ${+LESS_TERMCAP_so} )) && export LESS_TERMCAP_so=$'\e[1;33m'          # Begin standout mode
    (( ! ${+LESS_TERMCAP_ue} )) && export LESS_TERMCAP_ue=$'\e[24;0m'          # Exit underline mode
    (( ! ${+LESS_TERMCAP_md} )) && export LESS_TERMCAP_md=$'\e[01;34m'         # Turn on bold mode
    (( ! ${+LESS_TERMCAP_us} )) && export LESS_TERMCAP_us=$'\e[4;1;38;5;250m'  # Begin underline mode
fi

# Cargo/Rust (at the end to prevent PATH overwrites)
# [[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# # Settings: LS_COLORS
# LS_COLORS='no=0:fi=0:di=94'

# # Hidden files
# LS_COLORS+=":.*=34"

# # Programming (purple)
# LS_COLORS+=":*.py=36:*.sh=36"
# LS_COLORS+=":*Dockerfile=36:*Makefile=36"

# # Text files (green)
# LS_COLORS+=":*.md=32:*.txt=32:*.html=32"

# # Config files (yellow)
# LS_COLORS+=":*.json=33:*.toml=33:*.yml=33"
# LS_COLORS+=":*.in=33:*.conf=33:*.example=33"
# LS_COLORS+=":.zshenv=33:.zshrc=33:.zprofile=33:.zlogin=33:.zlogout=33:.zsh_history=33"
# export LS_COLORS

# export LS_COLORS="$(vivid generate iceberg-dark)" # brew install vivid
# # catppuccin-frappe, iceberg-dark, jellybeans, tokyonight-storm, nord

# https://gist.github.com/thomd/7667642
