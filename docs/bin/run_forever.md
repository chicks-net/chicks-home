# run_forever

Loop forever, printing a heartbeat. A long-running test fixture.

## Synopsis

```bash
run_forever
```

## Description

`run_forever` is a trivial bash script that loops forever, printing its PID
and `still running` every 10 seconds. It's the long-running counterpart to
[run_10s](run_10s.md) - a job that never exits on its own, intended for
testing wrappers that need to track a process that's expected to keep
running (or be killed externally).

No arguments, no flags. Ctrl-C (or `kill`) is the only way out.

## Examples

```bash
# Use it to test a supervisor script
run_forever &
SUPERVISED_PID=$!
# ... later ...
kill $SUPERVISED_PID
```

## See Also

- [run_10s.md](run_10s.md) - the short-running counterpart
- [start_synergy.md](start_synergy.md) - a real supervisor script for synergys
- [lib.sh.md](lib.sh.md) - the `spinner` library
