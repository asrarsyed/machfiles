# Profile File! Runs on Login! Configurations are set here!
# Global Order: zshenv, zprofile, zshrc, zlogin, zlogout

# Set starship config before caching
[[ -n $(command -v starship) ]] && export STARSHIP_CONFIG=$HOME/.config/starship/version01.toml

# <- Pre-load Essential Files ->
local -a config_files=(
    "$ZDOTDIR/options.zsh"
    "$ZDOTDIR/exports.zsh"
    "$HOME/.local/share/zap/zap.zsh"
)

for file in $config_files; do
    [[ -f $file ]] && source $file
done

# <- Load Essential Plugins ->

# Load fast plugins first
plug "zsh-users/zsh-autosuggestions"

# Load heavier plugins
plug "Aloxaf/fzf-tab"
plug "zap-zsh/vim"              # (Additional Plugin)
plug "momo-lab/zsh-replace-multiple-dots" # Load after vim
plug "hlissner/zsh-autopair"    # Slow (Essential Plugin)
plug "zsh-users/zsh-history-substring-search"

# Load syntax highlighting last (it needs to see all other widgets/bindings)
plug "zsh-users/zsh-syntax-highlighting"

# <- Archived Plugins ->
# plug "romkatv/powerlevel10k"    # Secondary Theme
# plug "Freed-Wu/fzf-tab-source"  # Very Slow (Additional Plugin)

# <- Source Local Configurations ->
local -a local_configs=(
    "$ZDOTDIR/supercharge.zsh"
    "$ZDOTDIR/fzf.zsh"
    "$ZDOTDIR/aliases.zsh"
    "$ZDOTDIR/functions.zsh"
)

for config in $local_configs; do
    [[ -f $config ]] && source $config
done

# <- Initialize Tools ->
function cache_init() {
    local tool=$1
    local cache_file="$zcachedir/.${tool}.zsh"
    local init_cmd=$2
    
    if [[ ! -f $cache_file ]] || [[ $(which $tool) -nt $cache_file ]]; then
        eval "$init_cmd" > $cache_file
    fi
    source $cache_file
}

# Cache tool initializations
cache_init "fnm" "fnm env"
cache_init "fzf" "fzf --zsh"
cache_init "zoxide" "zoxide init zsh"
# cache_init "zoxide" "zoxide init zsh --no-cmd" # Default auto CDing
[[ -n $(command -v starship) ]] && cache_init "starship" "starship init zsh"