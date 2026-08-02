# infect

Provision SSH keys into a host via tmux keystrokes.

## Synopsis

```bash
infect <tmux-target>
```

## Description

`infect` is a short bash script that, given a tmux target, sends keystrokes
to:

1. Create `~/.ssh` on the remote host.
2. Set its permissions to `700`.
3. Download the repo's `authorized_keys` from GitHub raw.

The name is cheeky - it's "infecting" the target with your SSH keys, which is
a quick way to bootstrap access on a fresh machine you've already got a
shell on (e.g. via a tmux-shared console or a serial console).

It exits with status 1 if no tmux target is supplied.

## Arguments

| Argument | Description |
| --- | --- |
| `tmux-target` | tmux pane target to send the keystrokes to. Required. |

## Examples

```bash
# Infect the host visible in tmux pane 1
infect mysession:0.1
```

## See Also

- [plague.md](plague.md) - run `infect` across a list of data centers
- [clone_merge_chicks.md](clone_merge_chicks.md) - migrate a home directory onto `chicks-home`
