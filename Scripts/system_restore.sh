#!/bin/bash

# Script to restore system-level preferences from a backup file
# Pairs with system_backup.sh to restore preferences for each domain

backup_dir="$HOME/system_backups"
log_dir="$backup_dir"

# Function to list available backups
list_backups() {
    echo "Available backups:"
    local i=1
    while IFS= read -r file; do
        echo "$i) $(basename "$file") ($(date -r "$file" "+%Y-%m-%d %H:%M:%S"))"
        ((i++))
    done < <(find "$backup_dir" -name "system_preferences_backup_*.plist" -type f | sort -r)
}

# Function to select a backup file
select_backup() {
    local backup_files=()
    while IFS= read -r file; do
        backup_files+=("$file")
    done < <(find "$backup_dir" -name "system_preferences_backup_*.plist" -type f | sort -r)

    if [ ${#backup_files[@]} -eq 0 ]; then
        echo "No backup files found in $backup_dir"
        exit 1
    fi

    list_backups

    read -p "Select backup to restore (1-${#backup_files[@]}): " selection
    if ! [[ "$selection" =~ ^[0-9]+$ ]] || [ "$selection" -lt 1 ] || [ "$selection" -gt ${#backup_files[@]} ]; then
        echo "Invalid selection"
        exit 1
    fi

    echo "${backup_files[$((selection-1))]}"
}

# Generate timestamp for the restore log
timestamp=$(date +"%Y%m%d_%H%M%S")
log_file="$log_dir/restore_log_$timestamp.txt"

# Select backup file to restore
backup_file=$(select_backup)
if [ ! -f "$backup_file" ]; then
    echo "Selected backup file not found!" | tee -a "$log_file"
    exit 1
fi

echo "Starting restore from $(basename "$backup_file") at $(date)" | tee -a "$log_file"

# Create temporary directory for domain extraction
temp_dir=$(mktemp -d)
trap 'rm -rf "$temp_dir"' EXIT

# List of domains to restore (should match backup script)
domains=(
    NSGlobalDomain
    com.apple.systempreferences
    com.apple.finder
    com.apple.dock
    com.apple.menuextra.clock
    com.apple.screensaver
    com.apple.desktop
    com.apple.spaces
    com.apple.universalaccess
    com.apple.loginwindow
    com.apple.controlcenter
    com.apple.systemuiserver
    com.apple.sound
    com.apple.inputmethod.Kotoeri
    com.apple.iokit
    com.apple.Bluetooth
    com.apple.wifi
    com.apple.print
    com.apple.TimeMachine
    com.apple.energysaver
    com.apple.NetworkBrowser
    com.apple.security
    com.apple.preferences.sharing
    com.apple.AppleMultitouchTrackpad
    com.apple.keyboard
    com.apple.mouse
    com.apple.smb.server
    com.apple.HIToolbox
)

# Counter for successful imports
successful_imports=0

for domain in "${domains[@]}"; do
    echo "Restoring $domain..." | tee -a "$log_file"
    
    # Extract domain preferences to temporary file
    temp_plist="$temp_dir/${domain}.plist"
    if /usr/libexec/PlistBuddy -x -c "Print :root:$domain" "$backup_file" > "$temp_plist" 2>> "$log_file"; then
        # Check if we got valid preferences
        if [ -s "$temp_plist" ]; then
            # Import preferences for this domain
            if defaults import "$domain" "$temp_plist" 2>> "$log_file"; then
                ((successful_imports++))
                echo "Successfully restored $domain" | tee -a "$log_file"
            else
                echo "Failed to import preferences for $domain" | tee -a "$log_file"
            fi
        else
            echo "No preferences found for $domain in backup" | tee -a "$log_file"
        fi
    else
        echo "Failed to extract preferences for $domain from backup" | tee -a "$log_file"
    fi
done

echo "Restore complete! Successfully imported $successful_imports domains." | tee -a "$log_file"
echo "Log file: $log_file" | tee -a "$log_file"

# Notify user that some changes might require a restart
echo "Note: Some preference changes may require logging out and back in or restarting your Mac to take effect." | tee -a "$log_file"

# Ask if user wants to restart
read -p "Would you like to restart your Mac now? (y/N): " restart_choice
if [[ $restart_choice =~ ^[Yy]$ ]]; then
    echo "Restarting system..."
    sudo shutdown -r now
fi