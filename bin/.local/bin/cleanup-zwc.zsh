# First Script: ZWC Cleanup
#!/usr/bin/env zsh
function cleanup_zwc() {
    local zcachedir="$XDG_CACHE_HOME/zsh"
    local count=0
    
    # Create cache directory if it doesn't exist
    mkdir -p "$zcachedir"
    echo "🧹 Cleaning up compiled zsh files..."
    
    # Clean the cache directory first
    echo "Cleaning cache directory..."
    rm -f "$zcachedir"/*.zwc
    
    # Move and compile tool cache files
    local -a cache_files=(
        "$ZDOTDIR/.fzf.zsh"
        "$ZDOTDIR/.starship.zsh"
        "$ZDOTDIR/.zoxide.zsh"
        "$ZDOTDIR/.zcompdump"
    )
    
    for cache in $cache_files; do
        local basename="${cache:t}"
        if [[ -f "$cache" && ! -L "$cache" ]]; then
            echo "Moving $basename to cache directory"
            if [[ -f "$zcachedir/${basename#.}" ]]; then
                mv "$zcachedir/${basename#.}" "$zcachedir/${basename#.}.backup"
            fi
            mv "$cache" "$zcachedir/${basename#.}"
            ln -sf "$zcachedir/${basename#.}" "$cache"
        fi
    done
    
    # Compile config files into cache directory
    local -a config_files=(
        "$ZDOTDIR/options.zsh"
        "$ZDOTDIR/exports.zsh"
        "$ZDOTDIR/aliases.zsh"
        "$ZDOTDIR/functions.zsh"
        "$ZDOTDIR/fzf.zsh"
        "$ZDOTDIR/supercharge.zsh"
        "$ZDOTDIR/.zlogin"
        "$ZDOTDIR/.zprofile"
        "$ZDOTDIR/.zshrc"
    )
    
    for config in $config_files; do
        local basename="${config:t}"
        if [[ -f "$config" ]]; then
            echo "Compiling $basename to cache directory"
            zcompile "$zcachedir/${basename%.zsh}.zwc" "$config"
            ((count++))
        fi
    done
    
    # Compile completion cache in zcachedir
    if [[ -f "$zcachedir/zcompdump" ]]; then
        echo "Recompiling completion cache"
        zcompile "$zcachedir/zcompdump"
    fi
    
    echo "\n✨ Cleanup complete! Compiled $count files into $zcachedir"
    echo "\nCache directory contents:"
    ls -la "$zcachedir"
}

# Run the cleanup
cleanup_zwc