# haproxy_stats

Per-minute connection statistics from an HAProxy log file.

## Synopsis

```bash
haproxy_stats
```

## Description

`haproxy_stats` is a Perl script that parses a hardcoded HAProxy log file
(`/mnt/log/haproxy.log`) and produces per-minute connection statistics:

- Average connection time.
- Average total time.
- Connection count.
- Breakdown of termination states with counts and percentages.

It auto-detects whether each line is TCP or HTTP log format and recognizes
the common HAProxy termination states (`--`, `CD`, `PR--`, `SC`, `sC`, etc.).
Output goes to STDOUT, one row per minute.

The log path is hardcoded; copy the script and change the path if your logs
live elsewhere. Extensively documented with embedded POD; authored by
Christopher Hicks.

No arguments, no flags.

## Examples

```bash
$ haproxy_stats
2026-07-31 09:00  avg_conn=0.012  avg_total=0.345  count=1234  terms=--:1000 CD:234
```

## See Also

- [watch_constate.md](watch_constate.md) - TCP/UDP connection-state watcher
- [check_ssl.md](check_ssl.md) - TLS certificate monitoring
