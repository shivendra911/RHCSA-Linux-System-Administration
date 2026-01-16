#!/bin/bash

# ---- SETTINGS ----
# The email address for alerts.
# (Note: This won't work until a mail server is installed).
RECIPIENT="admin@mycomp.com"

# The location of the log file.
LOG_FILE="/var/log/zombie_detector.log"
# ---- END SETTINGS ----

echo "$(date): Scanning for zombie processes..." >> "$LOG_FILE"

# Use the 'ps' command to find any processes in the "zombie" state ('Z').
ZOMBIE_PROCESSES=$(ps aux | awk '$8=="Z"')

# Check if we found any zombies.
if [ -n "$ZOMBIE_PROCESSES" ]; then
  # If we found zombies, log a warning!
  echo "WARNING: Zombie processes were detected!"
  echo "$(date): ALERT! Found zombie processes:" >> "$LOG_FILE"
  echo "$ZOMBIE_PROCESSES" >> "$LOG_FILE"

  # This part would try to email the alert, but will fail for now.
else
  # If everything is clean, log a normal message.
  echo "OK: No zombie processes found."
  echo "$(date): OK: System is clean, no zombies found." >> "$LOG_FILE"
fi
