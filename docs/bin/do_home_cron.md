# do_home_cron

Run every executable script inside a `~/cron.d/<name>` directory.

## Synopsis

```bash
do_home_cron <cron-dir-name>
```

## Description

`do_home_cron` is a Perl cron-style runner. Given the name of a subdirectory
under `~/cron.d`, it iterates over every executable, non-hidden, non-swap
(`.swp`), non-emacs-backup (`~`) file inside it and runs each one via
`system()`. This lets you organize small periodic jobs as individual files
inside a named cron group (e.g. `~/cron.d/daily/`) rather than cramming them
all into a single crontab entry or one big script.

It dies if the directory is missing or any script inside is missing or not
executable, which surfaces permission problems early instead of silently
skipping them.

## Arguments

| Argument | Description |
| --- | --- |
| `cron-dir-name` | Subdirectory under `~/cron.d` whose scripts should be run. Required. |

## Examples

```bash
# Run every script in ~/cron.d/daily/
do_home_cron daily
```

## See Also

- [daily_desktop_cleanup.md](daily_desktop_cleanup.md) - a typical daily job
- [daily_mysql_backup.md](daily_mysql_backup.md) - another daily job
