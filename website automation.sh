#complex shell script that automates website backup and rotation
#!/bin/bash

# Define script variables
WEBSITE_DIR="/var/www/mysite"  # Directory containing website files
BACKUP_DIR="/backups/website"  # Backup directory
MAX_BACKUPS=5  # Maximum number of backups to keep

# Function to check if a directory exists
function dir_exists() {
  [ -d "$1" ] && return 0 || return 1
}

# Function to create a timestamped backup directory
function create_backup_dir() {
  local timestamp=$(date +%Y-%m-%d_%H-%M-%S)
  local backup_name="$BACKUP_DIR/$timestamp"
  mkdir -p "$backup_name"
  echo "Backup directory created: $backup_name"
}

# Function to compress website directory into a tar archive
function compress_website() {
  local backup_dir="$1"
  tar -czvf "$backup_dir/website.tar.gz" "$WEBSITE_DIR"
  echo "Website compressed to: $backup_dir/website.tar.gz"
}

# Function to clean up old backups
function clean_old_backups() {
  local backup_count=$(ls -d "$BACKUP_DIR"*/ | wc -l)
  while [[ $backup_count -gt $MAX_BACKUPS ]]; do
    local oldest_backup=$(ls -dt "$BACKUP_DIR"*/ | tail -n 1)
    rm -rf "$oldest_backup"
    echo "Deleted oldest backup: $oldest_backup"
    ((backup_count--))
  done
}

# Check if backup directory exists, create if not
if ! dir_exists "$BACKUP_DIR"; then
  mkdir -p "$BACKUP_DIR"
fi

# Create a timestamped backup directory
create_backup_dir

# Compress website directory into the backup directory
compress_website "$(create_backup_dir)"

# Clean up old backups to maintain a maximum number
clean_old_backups

echo "Website backup completed!"
