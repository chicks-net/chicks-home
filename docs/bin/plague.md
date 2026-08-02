# plague

Provision SSH keys across a list of data centers via `infect`.

## Synopsis

```bash
plague
```

## Description

`plague` is a Perl script that automates SSH-ing into a list of data centers
(`@dcs`), accepting the host keys, supplying a password read from
`~/.creds`, then running the [infect](infect.md) script via tmux to provision
SSH keys, and logging out. It targets a hardcoded tmux session
(`mint-chicks:3.0`).

In its current state it's mostly a scaffold - the `@dcs` list is empty, so
running it as-is is a no-op. Fill in the data center list (and adjust the
tmux session name) before expecting anything to happen.

The name is a nod to the script's "infect" building block: it spreads the
"infection" (your SSH keys) across a fleet of hosts, like a plague.

No arguments, no flags.

## See Also

- [infect.md](infect.md) - the per-host provisioning script `plague` drives
- [clone_merge_chicks.md](clone_merge_chicks.md) - migrate a home directory
  onto the `chicks-home` layout
