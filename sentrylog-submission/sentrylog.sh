#!/usr/bin/env bash
REPORT="/var/log/sentrylog_report.txt"
FAILCOUNT=0

echo "===== SentryLog Security Digest — $(date) =====" > "$REPORT"

echo "" >> "$REPORT"
echo "--- Failed login attempts (last 24 hours) ---" >> "$REPORT"
journalctl --since "24 hours ago" | grep -i "Failed password" >> "$REPORT"

echo "" >> "$REPORT"
echo "--- Service failures (priority: error and above) ---" >> "$REPORT"
journalctl --since "24 hours ago" -p err >> "$REPORT"

echo "" >> "$REPORT"
echo "--- Failure count check ---" >> "$REPORT"
FAILCOUNT=$(journalctl --since "24 hours ago" | grep -c -i "Failed password")

if [ "$FAILCOUNT" -gt 5 ]; then
    echo "WARNING: $FAILCOUNT failed login attempts detected — investigate." >> "$REPORT"
else
    echo "OK: $FAILCOUNT failed login attempts (within normal range)." >> "$REPORT"
fi

echo "Report saved to $REPORT"

