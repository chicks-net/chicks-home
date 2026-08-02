# tim

Python reimplementation of `time(1)` with console, syslog, and Slack logging.

## Synopsis

```bash
tim COMMAND [args ...]
```

## Description

`tim` is a Python reimplementation of the classic `time(1)` command that
additionally logs results to the console, syslog, and (optionally) Slack.

It forks and execs the given command, then reaps it with `os.wait3` and
reports:

- Real, user, and system time in `Hh Mm S.ss` form.
- `maxrss` (max resident set size).
- `minflt` / `maxflt` (minor / major page faults).
- The command's exit status.

Slack notifications require the `slack-log-handler` Python package and a
`SLACK_TOKEN` environment variable. The dependency is pinned in
`bin/Pipfile` (`slack-log-handler = "*"`, locked to `0.3.0` in
`bin/Pipfile.lock`).

## Arguments

| Argument | Description |
| --- | --- |
| `COMMAND [args...]` | The command to time, with any arguments. Required. |

## Environment

| Variable | Description |
| --- | --- |
| `SLACK_TOKEN` | Optional. If set (with `slack-log-handler` installed), log results to Slack. |

## Examples

```bash
# Time a build and log it
tim make all

# Time a deploy
tim ./deploy.sh production
```

## See Also

- [countdown.md](countdown.md) - an adaptive countdown timer
- [whenis.md](whenis.md) - epoch-to-human-readable time across time zones
- `bin/Pipfile` / `bin/Pipfile.lock` - Python dependency manifests for the
  Slack feature
