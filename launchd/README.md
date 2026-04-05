# Setting Up Automated Desktop Cleanup with launchd

This guide shows you how to schedule the desktop cleanup script to run automatically
daily at 2 AM on macOS using launchd.

## Quick Setup

**Important**: The plist file contains hardcoded paths. Use `just launchd-install`
which automatically substitutes paths for your repository location. Do **not**
manually copy the plist file without editing it first - it will have incorrect
paths.

The `just launchd-install` command:

1. Finds your repository root
2. Substitutes hardcoded paths in the plist
3. Copies the plist to `~/Library/LaunchAgents/`
4. Loads the job with launchctl

If you must copy manually, edit these paths in the plist first:

- `ProgramArguments` - path to `bin/daily_desktop_cleanup.go`
- `StandardOutPath` and `StandardErrorPath` - log file paths

Then copy and load:

```bash
# After editing paths manually
cp launchd/net.chicks.daily-desktop-cleanup.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/net.chicks.daily-desktop-cleanup.plist
```

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
just launchd-reload
```

This unloads the old job, copies the updated plist with correct paths, and
loads the new version.

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
2. Verify the script runs manually:

    ```bash
    go run bin/daily_desktop_cleanup.go
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
- Runs when you're logged in (LaunchAgents run in your user session)
- More flexible scheduling options
- Resource management

Note: LaunchAgents (stored in `~/Library/LaunchAgents`) only run when you're
logged in. For jobs that need to run before login or without a user session,
use LaunchDaemons (stored in `/Library/LaunchDaemons`) instead.

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
