# <- ZSH Compdump Manager ->

local zcachedir="$XDG_CACHE_HOME/zsh"
local zcompdump="$zcachedir/zcompdump"
local zcompdump_link="$ZDOTDIR/.zcompdump"

# Add fnm completions directory
fpath+=~/.config/zsh/completions

# Ensure cache directory exists
mkdir -p "$zcachedir"

# Ensure symlink exists
[[ -L "$zcompdump_link" ]] || ln -sf "$zcompdump" "$zcompdump_link"

# Load completions
autoload -Uz compinit

# Only regenerate completion dump once per day
# Check the actual cache file, not the symlink
for dump in "$zcompdump"(N.mh+24); do
    compinit -d "$zcompdump"  # Specify dump location
done
compinit -C -d "$zcompdump"  # Specify dump location

# Compile zcompdump in background if needed
{
    if [[ -s "$zcompdump" && (! -s "$zcompdump.zwc" || "$zcompdump" -nt "$zcompdump.zwc") ]]; then
        zcompile "$zcompdump"
    fi
} &!

# --- Older ersion ---------------------------------

# # Comp stuff and autoloading them
# autoload -Uz compinit
# for dump in "${ZDOTDIR:-$HOME}/.zcompdump"(N.mh+24); do
#     compinit
# done
# compinit -C

# # Execute code in the background to not affect the current session
# {
#     # Compile zcompdump, if modified, to increase startup speed.
#     zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
#     if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
#         zcompile "$zcompdump"
#     fi
# } &!

# <- Completion + Styling ->

# Case-insensitive matching (ranked from slowest-fastest)
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' '+r:|?=**'

# Menu-based selection
zstyle ':completion:*:default' menu select
zstyle ':completion:*' increment yes
zstyle ':completion:*' verbose yes
zstyle ':completion:*' squeeze-slashes yes  # replace // with /; may inadvertently mask issues when debugging paths

# Use faster hashtable for completion caching
zstyle ':completion:*' rehash false  # improves performance
zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path $zcachedir
zstyle ':completion:*' accept-exact '*(N)'

# Group and organize completion results
zstyle -d ':completion:*' format
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:warnings' format '%F{red}--- no matches ---%f' # Minimal
# zstyle ':completion:*:warnings' format '%B%F{red}No matches for:''%F{white}%d%b' # Detailed
zstyle ':completion:*' group-name '' # speeds up rendering; may reduce clarity when there are many suggestions
zstyle ':completion:*' file-sort modification  # show recently used files first
zstyle ':completion:*' list-dirs-first yes
zstyle ':completion:*' ignored-patterns '.git'

# Colorize completion candidates
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' special-dirs true

# _complete is base completer (standard completion for commands, files, etc.)
# _approximate will fix completion if there are no exact matches (e.g., correct typos)
# _extensions will complete glob patterns with extensions (e.g., `*.txt` or `*.sh`)
# _history will search through the shell's command history for matches
# _match will complete substrings or patterns within a word
# Optimize completion order (faster than history-based)
zstyle ':completion:*' completer _complete _match _approximate

# Optimize cd completion (faster path handling)
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack named-directories path-directories
zstyle ':completion:*:cd:*' group-order local-directories directory-stack named-directories path-directories

# Optimize sudo completion (faster path search)
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# NOTE: fzf-tab settings
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' popup-min-size 80 20
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

# Async run git status asynchronously in the background to prevent lag
function async_git_status() { (git status --porcelain &>/dev/null &) }
autoload -Uz add-zsh-hook
add-zsh-hook precmd async_git_status

# Load modules more efficiently
{
    # Load only needed modules
    zmodload zsh/complist
    zmodload zsh/complete
    zmodload zsh/zutil
} &!

# Include hidden files for completion
_comp_options+=(globdots)  # Include hidden files.
zle_highlight=('paste:none')
autoload -Uz zmv
zmodload zsh/zprof

# <- History Search Bindings ->
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# <- Custom Keybindings ->
    # Use "bindkey -l" to list available key bindings
    # Use "bindkey -M viins" to list key bindings for insert mode
    # Use "bindkey -M vicmd" to list key bindings for command mode

bindkey '^ ' autosuggest-accept     # Ctrl+Space: Accept the auto-suggestion
bindkey '^[[A' history-substring-search-up     # Up Arrow: Search upwards in history (matches current input substring)
bindkey '^[[B' history-substring-search-down   # Down Arrow: Search downwards in history (matches current input substring)
bindkey -M vicmd 'k' history-substring-search-up   # 'k' (vi command mode): Search upwards in history (substring match)
bindkey -M vicmd 'j' history-substring-search-down # 'j' (vi command mode): Search downwards in history (substring match)
bindkey -s '\el' 'ls\n' # [Esc-l] - runs command: ls

# READLINE
bindkey '^w' backward-kill-word
bindkey '^e' end-of-line
bindkey '^a' beginning-of-line
bindkey '^f' forward-word

# <- Colors ->
autoload -Uz colors && colors

# <- LS Aliases -> (Optional)
case $OSTYPE in
    darwin*) alias ls='ls -G';;
    linux*) alias ls='ls --color=auto';;
esac

# <- Plugin: syntax highlighting ->
ZSH_HIGHLIGHT_MAXLENGTH=120
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Rainbow brackets in special order, easier for eyes
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=green'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=blue'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[bracket-level-5]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[bracket-level-6]='fg=red'

# Custom styles
# Errors
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,underline'

# Keywords
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=blue'

# Commands
ZSH_HIGHLIGHT_STYLES[precommand]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=magenta'

# Strings
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=yellow'

# Redirections
ZSH_HIGHLIGHT_STYLES[redirection]='fg=cyan'

# Paths
ZSH_HIGHLIGHT_STYLES[path]='none'