# Setting Up Automated Desktop Cleanup with launchd

This guide shows you how to schedule the desktop cleanup script to run automatically
daily at 2 AM on macOS using launchd.

## Quick Setup

**Important**: The plist file contains hardcoded paths. You must edit it first
to match your repository location. Use `just launchd-install` which handles this
automatically, or manually update these paths in the plist:

- `ProgramArguments` - path to `bin/daily_desktop_cleanup`
- `WorkingDirectory` - repo root directory
- `StandardOutPath` and `StandardErrorPath` - log file paths

Copy the plist file to your LaunchAgents directory and load it:

```bash
# Copy the plist file
cp launchd/net.chicks.daily-desktop-cleanup.plist ~/Library/LaunchAgents/

# Load the job
launchctl load ~/Library/LaunchAgents/net.chicks.daily-desktop-cleanup.plist

# Start it immediately (optional - RunAtLoad already does this)
launchctl start net.chicks.daily-desktop-cleanup
```

That's it! The cleanup will now run daily at 2 AM.

## Verifying It Works

Check if the job is loaded:

```bash
launchctl list | grep daily-desktop-cleanup
```

You should see output like:

```text
-    0    net.chicks.daily-desktop-cleanup
```

Check the logs:

```bash
tail -f launchd/daily-desktop-cleanup.log
```

## Managing the Job

### Stop the job

```bash
launchctl stop net.chicks.daily-desktop-cleanup
```

### Unload the job (disable it)

```bash
launchctl unload ~/Library/LaunchAgents/net.chicks.daily-desktop-cleanup.plist
```

### Reload after making changes

```bash
launchctl unload ~/Library/LaunchAgents/net.chicks.daily-desktop-cleanup.plist
cp launchd/net.chicks.daily-desktop-cleanup.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/net.chicks.daily-desktop-cleanup.plist
```

## Customizing the Schedule

The plist file uses `StartCalendarInterval` to run daily at 2 AM. To change
the time, edit the plist file:

```xml
<!-- Run daily at 2 AM -->
<key>StartCalendarInterval</key>
<dict>
    <key>Hour</key>
    <integer>2</integer>
    <key>Minute</key>
    <integer>0</integer>
</dict>
```

### Alternative: Multiple Times Per Day

If you want to run multiple times per day, use an array:

```xml
<!-- Run twice daily at 8 AM and 8 PM -->
<key>StartCalendarInterval</key>
<array>
    <dict>
        <key>Hour</key>
        <integer>8</integer>
        <key>Minute</key>
        <integer>0</integer>
    </dict>
    <dict>
        <key>Hour</key>
        <integer>20</integer>
        <key>Minute</key>
        <integer>0</integer>
    </dict>
</array>
```

### Alternative: Interval-Based Scheduling

If you prefer interval-based scheduling, replace `StartCalendarInterval` with
`StartInterval`:

```xml
<!-- Run every 24 hours (86400 seconds) -->
<key>StartInterval</key>
<integer>86400</integer>
```

Common intervals:

- Every hour: `3600`
- Every 6 hours: `21600`
- Every 12 hours: `43200`
- Daily: `86400`

## Log Files

The plist configuration creates two log files in the launchd directory:

- `daily-desktop-cleanup.log` - Standard output (files moved)
- `daily-desktop-cleanup.err` - Error output (failures)

View recent activity:

```bash
tail -20 launchd/daily-desktop-cleanup.log
```

Check for errors:

```bash
tail -20 launchd/daily-desktop-cleanup.err
```

## Troubleshooting

### Job won't load

Check for syntax errors in the plist:

```bash
plutil -lint ~/Library/LaunchAgents/net.chicks.daily-desktop-cleanup.plist
```

### Job loads but doesn't run

1. Check the logs for errors
2. Verify the script is executable:

    ```bash
    chmod +x bin/daily_desktop_cleanup
    ```

3. Make sure the script path is correct in the plist file
4. Check permissions on the Desktop and Pictures directories

### Script fails to move files

The script needs permission to access Desktop and Pictures folders. On macOS,
you may need to grant Full Disk Access to the terminal or the script:

1. Open System Preferences → Privacy & Security →
      Full Disk Access
2. Add Terminal.app (or your terminal emulator)
3. Restart the terminal and reload the launchd job

## Why launchd Instead of Cron?

macOS uses launchd as its primary job scheduler. While cron still works, launchd
provides better integration with macOS including:

- Automatic restart on failure
- Better logging
- Runs even when not logged in
- More flexible scheduling options
- Resource management

## Notes

- Hardcoded paths in the plist are automatically substituted by
  `just launchd-install` and `just launchd-reload`
- The job runs with `Nice` priority 1, meaning it yields to other processes
- `RunAtLoad` is set to true, so it runs immediately when loaded - use
  `just launchd-run` for manual testing instead of reloading repeatedly
- The job doesn't keep alive - it runs, completes, and waits for the next
  scheduled time
- Screenshots older than 30 days are moved to `~/Pictures/ScreenShots`
- Logs are appended, not rotated - you may want to clean them periodically

## What the Script Does

The `daily_desktop_cleanup` script:

1. Creates `~/Pictures/ScreenShots` if it doesn't exist
2. Finds screenshots on the Desktop older than 30 days
3. Moves them to `~/Pictures/ScreenShots`
4. Reports which files were moved and how many remain

Run it manually to test:

```bash
bin/daily_desktop_cleanup
```
