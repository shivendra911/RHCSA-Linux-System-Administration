#!/bin/bash

# ---- SETTINGS ----
# The email address where the report should be sent.
# (Note: This won't work until a mail server is installed).
RECIPIENT="admin@mycomp.com"

# The location of the log file for this script.
LOG_FILE="/var/log/disk_report.log"
# ---- END SETTINGS ----

echo "Generating daily disk usage report..."

# Get the disk usage report in a human-friendly format.
DISK_REPORT=$(df -h)

# Write the report to our log file for historical records.
echo "--- Report for $(date) ---" >> "$LOG_FILE"
echo "$DISK_REPORT" >> "$LOG_FILE"
echo "--- End of Report ---" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# This part would try to email the report, but will likely fail for now.
# echo "$DISK_REPORT" | mail -s "Daily Disk Usage Report" "$RECIPIENT"

echo "Disk report has been saved to $LOG_FILE"
