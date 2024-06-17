#!/bin/bash

# Define the configuration file to store the settings
CONFIG_FILE="$HOME/backup_config"

# Function to prompt for input if the config file doesn't exist
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Configuration file not found. Setting up for the first time."

    # Prompt for the origin directory
    read -p "Enter the full path of the directory you want to back up: " ORIGIN_DIR
    echo "ORIGIN_DIR=\"$ORIGIN_DIR\"" > "$CONFIG_FILE"

    # Prompt for the destination in Storj
    read -p "Enter the destination in Storj (e.g., storj:bucket/path): " DEST_DIR
    echo "DEST_DIR=\"$DEST_DIR\"" >> "$CONFIG_FILE"

    # Prompt for the time to run the backup (in 24-hour format, e.g., 02:00)
    read -p "Enter the time for daily backup (HH:MM format): " BACKUP_TIME
    echo "BACKUP_TIME=\"$BACKUP_TIME\"" >> "$CONFIG_FILE"

    echo "Configuration saved."
fi

# Source the configuration file to get the saved variables
source "$CONFIG_FILE"

# Perform the backup using rclone copy with update to overwrite only newer files
rclone copy "$ORIGIN_DIR" "$DEST_DIR" --update --max-depth -1 --verbose --log-file=rclone.log

# Add a log entry
echo "$(date '+%Y-%m-%d %H:%M:%S') - Backup completed from $ORIGIN_DIR to $DEST_DIR" >> ~/backup.log

# Schedule the cron job for the backup
HOUR=${BACKUP_TIME:0:2}
MINUTE=${BACKUP_TIME:3:2}
CRON_JOB="$MINUTE $HOUR * * * $HOME/backup_to_storj.sh"
(crontab -l 2>/dev/null | grep -v "$HOME/backup_to_storj.sh"; echo "$CRON_JOB") | crontab -
