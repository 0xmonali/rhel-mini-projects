# SentryLog — RH134 Ch1 / Ch3 / Ch4 / Ch5

## Problem
Manually scrolling through daily logs to catch failed logins and service failures is slow and error-prone. This automates a daily security digest.

## Chapter mapping
- Ch1: script variables, if/then logic (Writing Simple Bash Scripts / Loops and Conditional Commands)
- Ch5: journalctl log analysis, persistent journal, chrony time sync
- Ch4: systemd timer units, tmpfiles.d temp file cleanup
- Ch3/Ch4: cron alternative for comparison

## How it works
sentrylog.sh pulls failed login attempts and error-priority events from the
journal in the last 24 hours, counts failed logins, and flags a warning if
the count exceeds 5. Runs daily at 06:00 via a systemd timer (sentrylog.timer),
with a cron equivalent also configured for comparison.

## Setup
sudo cp sentrylog.sh /usr/local/bin/sentrylog.sh
sudo chmod +x /usr/local/bin/sentrylog.sh
sudo cp sentrylog.service sentrylog.timer /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now sentrylog.timer
sudo cp sentrylog-cleanup.conf /etc/tmpfiles.d/
sudo systemd-tmpfiles --create /etc/tmpfiles.d/sentrylog-cleanup.conf

## Timer vs cron
A systemd timer supports Persistent=true (catches up a missed run after
downtime) and logs to the journal. Cron is simpler but has no built-in
catch-up for missed runs.

## Files
- sentrylog.sh
- sentrylog.service, sentrylog.timer
- sentrylog-cleanup.conf
- sentrylog_report.txt (sample output)
- sentrylog_commands.txt (command log)
