# host_scanner

Resolve hosts and probe for SSH (22) and NRPE (5666) reachability.

## Synopsis

```bash
host_scanner <file> [file ...]
```

## Description

`host_scanner` is a Perl script that reads hostnames (one per line) from one
or more files passed as arguments, resolves each via DNS, and probes for SSH
(port 22) and NRPE (port 5666) using `Net::Telnet`. For each host it prints a
tab-separated line with the hostname, resolved IP, and the list of reachable
services. When DNS resolution fails it prints `DNS fail` in the IP column
rather than aborting, so a single bad host doesn't kill the whole scan.

Output is tab-separated, so it pipes cleanly into `awk` / `column` /
spreadsheets.

## Arguments

| Argument | Description |
| --- | --- |
| `file` | One or more files containing hostnames, one per line. Required. |

## Examples

```bash
host_scanner hosts.txt
host_scanner webservers.txt dbservers.txt | column -t
```

## See Also

- [watch_constate.md](watch_constate.md) - connection-state watcher
- [check_ssl.md](check_ssl.md) - TLS certificate monitoring
