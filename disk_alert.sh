#!/bin/bash

# ---- SETTINGS ----
# Set the disk usage percentage that will trigger an alert.
# 80 means if the disk is over 80% full, it will try to send an alert.
THRESHOLD=80

# The email address where alerts should be sent.
# (Note: This won't work until a mail server is installed).
RECIPIENT="admin@mycomp.com"

# The location of the log file for this script.
LOG_FILE="/var/log/disk_alert.log"
# ---- END SETTINGS ----

# Get the current disk usage for the main partition (/)
# This command just gets the number, like "22" for 22%.
CURRENT_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')

# Let's write the current status to our log file.
echo "$(date): Checking disk space. Current usage is ${CURRENT_USAGE}%." >> "$LOG_FILE"

# Check if the current usage is more than our threshold.
if [ "$CURRENT_USAGE" -gt "$THRESHOLD" ]; then
  # If it is, print a warning to the screen and the log.
  echo "WARNING: Disk space is critically low at ${CURRENT_USAGE}%!"
  echo "$(date): ALERT! Disk space is over the ${THRESHOLD}% threshold." >> "$LOG_FILE"
  
  # This part tries to send an email, but it will likely fail for now.
  # echo "Subject: Disk Space Alert!" | sendmail -v "$RECIPIENT"
else
  # If everything is okay, just print a normal message.
  echo "OK: Disk space is normal at ${CURRENT_USAGE}%."
  echo "$(date): OK: Disk usage is normal." >> "$LOG_FILE"
fi
