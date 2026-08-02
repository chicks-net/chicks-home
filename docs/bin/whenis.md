# whenis

Convert a Unix epoch timestamp into human-readable times across time zones.

## Synopsis

```bash
whenis [-l] [-u] [epoch_seconds]
```

## Description

`whenis` is a Perl utility (using `DateTime`) that converts a Unix epoch
timestamp into human-readable times across multiple time zones. It defaults
to the current time if no timestamp is given, and prints the time in:

- UTC.
- The local system timezone (read from `/etc/timezone`).
- US Eastern.

Each line is annotated with the short zone name. Use `-l` to print only the
local time, or `-u` to print only UTC.

## Arguments

| Argument | Description |
| --- | --- |
| `epoch_seconds` | Optional. Unix epoch timestamp. Defaults to now. |

## Flags

| Flag | Description |
| --- | --- |
| `-l` | Print only the local time. |
| `-u` | Print only UTC. |

## Examples

```bash
# What time is it now, everywhere?
whenis

# What epoch 1700000000 was in the local zone only
whenis -l 1700000000
```

## See Also

- [countdown.md](countdown.md) - an adaptive countdown timer
- [tim.md](tim.md) - Python `time(1)` with logging
