#!/usr/bin/env zsh

function cleanup_zwc() {
    local zdotdir="${ZDOTDIR:-$HOME}"
    local zcachedir="$zdotdir/.zcache"
    local count=0

    # Create cache directory if it doesn't exist
    mkdir -p "$zcachedir"
    echo "🧹 Cleaning up compiled zsh files..."

    # Clean the cache directory first
    echo "Cleaning cache directory..."
    rm -f "$zcachedir"/*.zwc

    # Move and compile tool cache files
    local -a cache_files=(
        ".fzf.zsh"
        ".starship.zsh"
        ".zoxide.zsh"
        ".zcompdump"
    )

    for cache in $cache_files; do
        if [[ -f "$zdotdir/$cache" ]]; then
            echo "Moving $cache to cache directory"
            mv "$zdotdir/$cache" "$zcachedir/${cache#.}"
            ln -sf "$zcachedir/${cache#.}" "$zdotdir/$cache"
        fi
    done

    # Compile config files into cache directory
    local -a config_files=(
        "options.zsh"
        "exports.zsh"
        "aliases.zsh"
        "functions.zsh"
        "fzf.zsh"
        "supercharge.zsh"
	".zlogin"
	".zprofile"
        ".zshrc"
    )

    for config in $config_files; do
        if [[ -f "$zdotdir/$config" ]]; then
            echo "Compiling $config to cache directory"
            zcompile "$zcachedir/${config%.zsh}.zwc" "$zdotdir/$config"
            ((count++))
        fi
    done

    # Compile completion cache
    if [[ -f "$zcachedir/zcompdump" ]]; then
        echo "Recompiling completion cache"
        zcompile "$zcachedir/zcompdump"
    fi

    echo "\n✨ Cleanup complete! Compiled $count files into $zcachedir"

    # List cache directory contents
    echo "\nCache directory contents:"
    ls -la "$zcachedir"
}

# Run the cleanup
cleanup_zwc
