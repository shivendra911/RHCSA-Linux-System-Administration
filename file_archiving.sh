#!/bin/bash

# ---- SETTINGS ----
# The folder to scan for old files.
# !!! IMPORTANT: Change this to a real folder on your system!
SOURCE_DIR="/home/spratap/documents"

# The folder where old files should be moved.
# !!! IMPORTANT: Change this to a real folder on your system!
ARCHIVE_DIR="/home/spratap/archive"

# How many days old a file has to be before we archive it.
RETENTION_DAYS=30

# The location of the log file.
LOG_FILE="/var/log/file_archiver.log"
# ---- END SETTINGS ----

# First, make sure the source and archive folders actually exist.
if [ ! -d "$SOURCE_DIR" ] || [ ! -d "$ARCHIVE_DIR" ]; then
  echo "Error: Source or archive directory not found. Please check the script settings."
  exit 1
fi

echo "$(date): Starting the archiving process." >> "$LOG_FILE"

# This is the main command. It finds files in the source directory
# that are older than our retention days, and then moves them one by one.
find "$SOURCE_DIR" -type f -mtime +$RETENTION_DAYS -print0 | while IFS= read -r -d $'\0' file; do
    
    # Figure out the correct sub-folder structure for the archive.
    relative_path="${file#$SOURCE_DIR/}"
    destination_dir="$ARCHIVE_DIR/$(dirname "$relative_path")"
    
    # Create the sub-folder in the archive if it doesn't exist yet.
    mkdir -p "$destination_dir"
    
    # Move the file!
    mv "$file" "$destination_dir/"
    
    # Log what we did.
    echo "$(date): Moved old file: $file" >> "$LOG_FILE"
done

echo "File archiving process is complete. See log for details."
echo "$(date): Archiving process finished." >> "$LOG_FILE"
