# clone_merge_chicks

Migrate a home directory to the `chicks-home` git-tracked setup.

## Synopsis

```bash
clone_merge_chicks
```

## Description

`clone_merge_chicks` is a one-shot bash script for migrating a fresh machine
onto the `chicks-home` git-tracked home directory layout. It:

1. Moves the old `~/chicks` directory aside to `chicks.sys`.
2. Symlinks `~/chicks` to the new location.
3. Stashes existing dotfiles into a `backups.clone` directory.
4. `git clone`s `chicks-net/chicks-home` from GitHub and renames the result to
   `~/chicks`.

It also contains commented-out notes about ssh keygen and `dnetc` setup from
an older era. This is a historical / migration tool - on a machine that's
already on the new layout it's a no-op or a footgun, so don't run it
indiscriminately.

No flags, no arguments.

## See Also

- [infect.md](infect.md) - provision SSH keys into a host via tmux
- [plague.md](plague.md) - run `infect` across a list of data centers
