# lib.sh

Shared bash library providing a `spinner` helper.

## Synopsis

```bash
source lib.sh
spinner <pid>
```

## Description

`lib.sh` is a small bash library meant to be **sourced**, not executed. It
provides a single `spinner` function that displays a rotating `|/-\`
animation while a background process (identified by its PID) is alive,
refreshing every 0.75 seconds. When the background process exits, the spinner
stops.

It's the shared helper used by other scripts (notably [test_lib](test_lib.md)
and other long-running wrappers) to give the user something to look at while
a job runs.

## Functions

| Function | Description |
| --- | --- |
| `spinner` | Show a spinner while the given PID is alive. Takes one argument. |

## Examples

```bash
source lib.sh
slow_command &
spinner $!
```

## See Also

- [test_lib.md](test_lib.md) - the test harness that exercises `spinner`
- [run_10s.md](run_10s.md) - a 10-second sleeper used as a test job for `spinner`
- [run_forever.md](run_forever.md) - an infinite loop also useful as a test job
