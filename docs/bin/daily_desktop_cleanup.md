# daily_desktop_cleanup

Archive macOS screenshots older than 30 days off the Desktop.

## Synopsis

```bash
daily_desktop_cleanup
```

## Description

`daily_desktop_cleanup` is a Bash script that sweeps macOS screenshots older
than 30 days from `~/Desktop` into `~/Pictures/ScreenShots`. It uses `find
-maxdepth 1` with the name patterns `Screenshot*.png`, `Screen Shot*.png`,
and `Screenshot*.jpg` combined with `-mtime +30`, moves each matching file
via `mv`, logs every move, and prints a final count of how many screenshots
remain on the Desktop.

Intended to be run from a daily cron / launchd job so the Desktop stays
manageable without manual cleanup.

A Go port exists as [daily_desktop_cleanup.go](daily_desktop_cleanup.go.md)
that adds timestamped logging, error handling, and a safe `moveFile` that
refuses to overwrite existing destinations.

No arguments, no flags.

## Examples

```bash
# Run it from a daily crontab entry
0 9 * * * ~/chicks/bin/daily_desktop_cleanup
```

## See Also

- [daily_desktop_cleanup.go.md](daily_desktop_cleanup.go.md) - Go port
- [mv_mini_metro_screencaps.md](mv_mini_metro_screencaps.md) - another screenshot organizer
