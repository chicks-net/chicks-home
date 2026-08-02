# watch_constate

Watch network connection states like `vmstat` but for TCP/UDP connections.

## Synopsis

```bash
watch_constate [interval_seconds]
```

## Description

`watch_constate` parses `netstat -na --protocol=inet` and counts connections by
protocol and state: TCP `ESTABLISHED`, `LISTEN`, `SYN_*`, `FIN_WAIT*`,
`TIME_WAIT`, `CLOSE_WAIT`, `LAST_ACK`, and UDP. Each sample is printed as a
single tab-separated row prefixed with a timestamp, which makes the output
easy to grep, log, or chart.

With an interval argument it loops forever, sleeping that many seconds between
samples and printing column headers up top; without one it takes a single
snapshot and exits. It uses Perl's `DateTime` for the timestamp.

## Arguments

| Argument | Description |
| --- | --- |
| `interval_seconds` | Optional. If given, loop forever printing a row every N seconds. If omitted, take one snapshot and exit. |

## Examples

```bash
# Single snapshot
watch_constate

# Loop every 2 seconds (vmstat-style)
watch_constate 2
```

## See Also

- [check_ssl.md](check_ssl.md) - TLS certificate monitoring
- [watch_zk_conns.md](watch_zk_conns.md) - ZooKeeper-specific connection watcher
