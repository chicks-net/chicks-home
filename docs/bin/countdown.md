# countdown

Adaptive countdown timer that prints the remaining time at varying intervals.

## Synopsis

```bash
countdown <seconds>
```

## Description

`countdown` is a Perl adaptive countdown timer. Given a number of seconds,
it prints timestamped lines showing the remaining `MmSs` and the next sleep
duration, sleeping between prints. The sleep interval is adaptive:

- 60 seconds when more than a minute is left.
- 10 seconds when 20-60 seconds are left.
- Finer-grained (sub-10s) in the final 20 seconds.

This makes it pleasant as a pomodoro or long-running reminder timer: you get
coarse updates while there's plenty of time and rapid ticking as the deadline
approaches.

It dies with an error if no timeout is supplied.

## Arguments

| Argument | Description |
| --- | --- |
| `seconds` | Required. Total seconds to count down from. |

## Examples

```bash
# 25-minute pomodoro
countdown 1500

# Quick 30-second reminder
countdown 30
```

## See Also

- [tim.md](tim.md) - Python `time(1)` with logging
- [whenis.md](whenis.md) - epoch-to-human-readable time across time zones
