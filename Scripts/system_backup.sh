#!/bin/bash

# List all domains for system-level preferences using: defaults domains | tr ',' '\n'
# This script uses `defaults export` to back up system preferences in a single, consolidated .plist file.

# Create backup directory if it doesn't exist
backup_dir="$HOME/system_backups"
mkdir -p "$backup_dir"

# Generate timestamp for the backup
timestamp=$(date +"%Y%m%d_%H%M%S")
backup_file="$backup_dir/system_preferences_backup_$timestamp.plist"
log_file="$backup_dir/backup_log_$timestamp.txt"

# List of preference domains to back up, with explanations for each
domains=(
    NSGlobalDomain                     # System-wide preferences such as scrollbars, key repeat rates, etc.
    com.apple.systempreferences        # Preferences for the System Preferences app itself.
    com.apple.finder                   # Finder-specific settings (file manager).
    com.apple.dock                     # Dock settings, like icon size, magnification, and auto-hide.
    com.apple.menuextra.clock          # Menu bar clock settings (e.g., digital/analog, 24-hour time).
    com.apple.screensaver              # Screensaver-related settings.
    com.apple.desktop                  # Desktop background and related settings.
    com.apple.spaces                   # Mission Control and Spaces settings.
    com.apple.universalaccess          # Accessibility settings (e.g., zoom, voiceover, contrast).
    com.apple.loginwindow              # Login window settings and related preferences.
    com.apple.controlcenter            # Control Center settings introduced in recent macOS versions.
    com.apple.systemuiserver           # Menu bar extras and items (like Wi-Fi, battery, volume).
    com.apple.sound                    # System sound preferences (e.g., alert sounds, output/input device).
    com.apple.inputmethod.Kotoeri      # Keyboard and input method settings (e.g., Japanese input, emoji picker).
    com.apple.iokit                    # Low-level hardware settings, including some power-related preferences.
    com.apple.Bluetooth                # Bluetooth settings.
    com.apple.wifi                     # Wi-Fi-related preferences.
    com.apple.print                    # Printer-related settings.
    com.apple.TimeMachine              # Time Machine backup preferences.
    com.apple.energysaver              # Energy saver and battery settings.
    com.apple.NetworkBrowser           # Network browsing preferences (e.g., shared computers).
    com.apple.security                 # Security and privacy settings, including firewall configurations.
    com.apple.preferences.sharing      # File sharing, screen sharing, and other sharing settings.
    com.apple.AppleMultitouchTrackpad  # Trackpad settings, such as gestures.
    com.apple.keyboard                 # Keyboard settings, including input sources and shortcuts.
    com.apple.mouse                    # Mouse settings, such as scrolling speed and button configuration.
    com.apple.smb.server               # SMB server configuration, used for file sharing.
    com.apple.HIToolbox                # Input sources and keyboard layouts.
)

# Initialize the backup file with a root dictionary
/usr/libexec/PlistBuddy -c "Save" "$backup_file"
/usr/libexec/PlistBuddy -c "Add :root dict" "$backup_file"

echo "Starting backup at $(date)" | tee -a "$log_file"
echo "Backup file: $backup_file" | tee -a "$log_file"

# Counter for successful exports
successful_exports=0

# Temporary file for individual domain exports
temp_file="$backup_dir/temp_domain.plist"

for domain in "${domains[@]}"; do
    echo "Processing $domain..." | tee -a "$log_file"
    
    # Export domain to temporary file
    if defaults export "$domain" "$temp_file" 2>> "$log_file"; then
        if [ -s "$temp_file" ]; then  # Check if temp file is non-empty
            # Add domain as a dictionary under root
            if /usr/libexec/PlistBuddy -c "Add :root:$domain dict" "$backup_file" 2>/dev/null; then
                # Merge the temp file content under the domain key
                if /usr/libexec/PlistBuddy -c "Merge $temp_file :root:$domain" "$backup_file" 2>> "$log_file"; then
                    ((successful_exports++))
                    echo "Successfully backed up $domain" | tee -a "$log_file"
                else
                    echo "Failed to merge $domain preferences" | tee -a "$log_file"
                fi
            fi
        else
            echo "No preferences found for $domain" | tee -a "$log_file"
        fi
    else
        echo "Failed to export $domain" | tee -a "$log_file"
    fi
done

# Clean up temporary file
rm -f "$temp_file"

echo "Backup complete! Successfully exported $successful_exports domains." | tee -a "$log_file"
echo "Settings have been saved to $backup_file" | tee -a "$log_file"
echo "Log file: $log_file" | tee -a "$log_file"

# Verify backup file exists and is non-empty
if [ -s "$backup_file" ]; then
    echo "Backup file created successfully!" | tee -a "$log_file"
else
    echo "Warning: Backup file is empty or was not created properly!" | tee -a "$log_file"
fi