# start_synergy

Supervisor loop that keeps the Synergy server (`synergys`) running.

## Synopsis

```bash
start_synergy
```

## Description

`start_synergy` is a Bash script that acts as a poor-man's supervisor for the
Synergy server (`synergys`). Every 3 seconds it checks (via `lsof` on
listening TCP sockets) whether `synergys` is running; if not, it logs the
restart via `logger` and starts it again after a 10-second back-off.

It expects `/etc/synergy.conf` to exist and be readable by `synergys`.

Because it's a foreground loop, it's typically launched by a session
manager, cron `@reboot`, or a tmux window rather than a system service
manager - though wrapping it in a systemd unit is straightforward.

No arguments, no flags.

## Examples

```bash
# From a session-startup script
start_synergy &
```

## See Also

- [start_tmux.md](start_tmux.md) - per-host tmux session bootstrapper
- [run_forever.md](run_forever.md) - a generic infinite-loop test fixture
