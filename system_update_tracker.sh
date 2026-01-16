#!/bin/bash

# ---- SETTINGS ----
# The log file where we'll keep a history of update checks.
LOG_FILE="/var/log/system_update_tracker.log"
# ---- END SETTINGS ----

echo "$(date): Starting system update check." >> "$LOG_FILE"

# First, let's make sure the 'dnf' command actually exists on this system.
if ! command -v dnf &> /dev/null
then
    # If it doesn't, we can't continue. Log an error and exit.
    echo "Error: The DNF package manager was not found."
    echo "$(date): CRITICAL ERROR: 'dnf' command not found. Aborting." >> "$LOG_FILE"
    exit 1
fi

# Add a nice header to the log file for today's check.
echo "--- Available updates as of $(date) ---" >> "$LOG_FILE"

# This is the main command that checks for updates.
# It will run 'dnf check-update' and write whatever it finds (both success and error messages)
# directly into our log file.
#
# !!! NOTE: This command will fail until the system is registered. !!!
dnf check-update >> "$LOG_FILE" 2>&1

# Finish up.
echo "System update check is complete. See log for details."
echo "$(date): Update check finished." >> "$LOG_FILE"
echo "-------------------------------------------" >> "$LOG_FILE"
