# daily_mysql_backup

Back up MySQL databases via `xtrabackup` / `innobackupex`.

## Synopsis

```bash
daily_mysql_backup [-s server] [-d localdir] [-a | <db-name>...]
```

## Description

`daily_mysql_backup` is a Perl script (using `AppConfig`, `Sys::Hostname`,
and `IPC::Run`) that backs up MySQL databases via Percona's `xtrabackup` /
`innobackupex` to a local directory, with a planned rsync stage to push the
backup to a remote server. It reads `/etc/fini/daily_mysql_backup.conf`,
validates remote disk space via `ssh df`, and checks `~/.my.cnf` for MySQL
credentials before running.

You can back up all databases with `-a` or pass explicit database names.
The rsync / diff stages that would push the backup remotely are currently
`die "unimplemented"` - the local backup half works, the remote-sync half is
a stub waiting to be finished. Listed in the `README` as "in progress".

## Arguments

| Flag | Description |
| --- | --- |
| `-s server` | MySQL server to back up from. |
| `-d localdir` | Local directory to write the backup into. |
| `-a` | Back up all databases. |
| `<db-name>...` | One or more explicit database names (alternative to `-a`). |

## Examples

```bash
daily_mysql_backup -s db1.fini.net -d /var/backup/mysql -a
daily_mysql_backup -s db1.fini.net -d /var/backup/mysql orders users
```

## See Also

- [do_home_cron.md](do_home_cron.md) - cron-style runner for daily jobs
