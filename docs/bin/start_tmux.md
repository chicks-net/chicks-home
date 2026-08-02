# start_tmux

Create and attach a host-specific tmux session layout.

## Synopsis

```bash
start_tmux
```

## Description

`start_tmux` is a Bash script that creates and attaches a tmux session layout
that's customized per hostname. It dispatches on the machine's hostname with
cases for:

- `freshfruit*`
- `hellonurse.*`
- `c64.*`
- `efba*`
- a default fallback.

Each case creates a named session and several windows with predefined
working directories (typically `git` repos the user expects to work on that
box), then attaches to the session. Helpers `our_new_session`,
`our_new_window`, and `our_attach` accept session/window names plus an
optional directory.

Run it on login (or from a window manager binding) to get straight into the
expected window layout for the host.

No arguments, no flags.

## Examples

```bash
start_tmux
```

## See Also

- [start_synergy.md](start_synergy.md) - another session-startup helper
