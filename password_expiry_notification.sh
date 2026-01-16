#!/bin/bash

# ---- SETTINGS ----
# How many days before a password expires should we warn the user?
THRESHOLD_DAYS=7

# Location of the log file.
LOG_FILE="/var/log/password_expiry_notify.log"
# ---- END SETTINGS ----

echo "$(date): Starting password expiration check." >> "$LOG_FILE"

# Go through every user listed in the main password file.
for user in $(cut -d: -f1 /etc/passwd); do
  
  # Use the 'chage' command to check when the user's password expires.
  # We only care about users who have an expiration date set.
  expiry_info=$(chage -l "$user" | grep 'Password expires')
  
  if [[ "$expiry_info" != *"never"* ]]; then
    
    # Get the expiration date and today's date in a way we can compare them.
    expiry_date=$(echo "$expiry_info" | cut -d: -f2)
    expiry_seconds=$(date -d "$expiry_date" +%s)
    today_seconds=$(date +%s)
    
    # Calculate how many days are left.
    seconds_left=$((expiry_seconds - today_seconds))
    days_left=$((seconds_left / 86400))
    
    # If the password expires within our warning window...
    if [ "$days_left" -ge 0 ] && [ "$days_left" -le "$THRESHOLD_DAYS" ]; then
      
      # ...log a message about it!
      echo "$(date): WARNING: User '$user' password expires in $days_left days." >> "$LOG_FILE"
      # This would be where the email is sent, but it will fail for now.
    fi
  fi
done

echo "Password expiration check is complete."
echo "$(date): Password check finished." >> "$LOG_FILE"
