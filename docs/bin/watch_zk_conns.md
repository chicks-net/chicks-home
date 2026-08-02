# watch_zk_conns

Watch ZooKeeper-related TCP connections.

## Synopsis

```bash
watch_zk_conns
```

## Description

`watch_zk_conns` is a minimal nine-line Bash loop for watching TCP
connections to ZooKeeper. Every 10 seconds it prints the current date and
runs `netstat -nap | grep ^tcp | egrep ':(2181|3888|53494)'` to show
connections on the:

- ZooKeeper client port (`2181`).
- Leader election port (`3888`).
- An additional ZK-related port (`53494`) hardcoded for the original
  deployment.

It runs indefinitely until interrupted (Ctrl-C). The third port is
environment-specific; copy the script and adjust the port list for your
own setup.

No arguments, no flags.

## Examples

```bash
# Watch ZK connections until Ctrl-C
watch_zk_conns
```

## See Also

- [watch_constate.md](watch_constate.md) - general TCP/UDP connection-state watcher
- [host_scanner.md](host_scanner.md) - probe SSH / NRPE on a list of hosts
