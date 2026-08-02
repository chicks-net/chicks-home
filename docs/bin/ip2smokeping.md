# ip2smokeping

Turn a list of IPs into SmokePing config stanzas.

## Synopsis

```bash
ip2smokeping < input
cat ips.txt | ip2smokeping
```

## Description

`ip2smokeping` is a Perl filter that reads IPv4 addresses from STDIN (one
per line) and emits SmokePing config stanzas. For each address it converts
the dotted-quad form to a hex string for the section label, then writes the
`menu`, `title` ("... ICMP Latency"), and `host` directives for that target.
Drop the output into your SmokePing `Targets` config and reload.

No arguments, no flags; reads from `<>`.

## Examples

```bash
$ printf '10.0.0.1\n10.0.0.2\n' | ip2smokeping
+ 0a000001
menu = 0a000001
title = 0a000001 ICMP Latency
host = 10.0.0.1

+ 0a000002
menu = 0a000002
title = 0a000002 ICMP Latency
host = 10.0.0.2
```

## See Also

- [watch_constate.md](watch_constate.md) - connection-state watcher
- [host_scanner.md](host_scanner.md) - probe SSH / NRPE on a list of hosts
